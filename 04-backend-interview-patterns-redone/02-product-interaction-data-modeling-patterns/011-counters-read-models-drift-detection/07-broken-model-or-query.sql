SET search_path TO bip_pim_011;
WITH trusted AS (
  SELECT 'post_like' AS counter_type, post_id::text AS subject_id, like_count AS stored_count FROM post_count_read_models
  UNION ALL SELECT 'post_comment', post_id::text, comment_count FROM post_count_read_models
  UNION ALL SELECT 'follower', user_id::text, follower_count FROM user_count_read_models
  UNION ALL SELECT 'unread', user_id::text, unread_count FROM notification_count_read_models
), anchor AS (SELECT count(*) AS row_count FROM trusted), checks AS (
  SELECT 'source_like_count' contract_name, 'post:101' subject_id, stored_count::text observed_value, 'Broken query trusts stored like count as source' expected_reason FROM trusted WHERE counter_type='post_like' AND subject_id='101'
  UNION ALL SELECT 'read_model_like_count','post:101',stored_count::text,'Stored like counter is read-model state' FROM trusted WHERE counter_type='post_like' AND subject_id='101'
  UNION ALL SELECT 'source_comment_count','post:101',stored_count::text,'Broken query trusts stored comment count as source' FROM trusted WHERE counter_type='post_comment' AND subject_id='101'
  UNION ALL SELECT 'read_model_comment_count','post:101',stored_count::text,'Stored comment counter matches the read model row' FROM trusted WHERE counter_type='post_comment' AND subject_id='101'
  UNION ALL SELECT 'source_follower_count','user:2',stored_count::text,'Broken query trusts stored follower count as source' FROM trusted WHERE counter_type='follower' AND subject_id='2'
  UNION ALL SELECT 'read_model_follower_count','user:2',stored_count::text,'Stored follower counter is stale for Ben' FROM trusted WHERE counter_type='follower' AND subject_id='2'
  UNION ALL SELECT 'unread_count','user:1',stored_count::text,'Broken query trusts stored unread count as source' FROM trusted WHERE counter_type='unread' AND subject_id='1'
  UNION ALL SELECT 'drift_detected','all','none','Broken query never compares source and stored rows' FROM anchor
  UNION ALL SELECT 'no_drift_for_healthy_row','post:102','1','Broken query assumes healthy rows from read model presence' FROM anchor
  UNION ALL SELECT 'repair_candidate','all','none','Broken query never emits repair candidates' FROM anchor
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
