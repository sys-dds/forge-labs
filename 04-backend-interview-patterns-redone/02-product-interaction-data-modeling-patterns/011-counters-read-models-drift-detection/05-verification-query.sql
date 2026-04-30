SET search_path TO bip_pim_011;
WITH post_source AS (
  SELECT p.post_id, count(DISTINCT r.reaction_id) FILTER (WHERE r.deleted_at IS NULL AND r.reaction_type='liked') AS source_likes, count(DISTINCT c.comment_id) FILTER (WHERE c.deleted_at IS NULL) AS source_comments
  FROM posts p LEFT JOIN post_reactions r ON r.post_id=p.post_id LEFT JOIN comments c ON c.post_id=p.post_id WHERE p.deleted_at IS NULL GROUP BY p.post_id
), follower_source AS (SELECT followed_user_id AS user_id, count(*) AS source_followers FROM follow_edges WHERE state='active' GROUP BY followed_user_id), unread_source AS (SELECT recipient_user_id AS user_id, count(*) AS source_unread FROM notifications WHERE state='unread' GROUP BY recipient_user_id), drift AS (
  SELECT 'post_like' AS drift_type, ps.post_id::text AS subject_id, (ps.source_likes - rm.like_count)::text AS delta FROM post_source ps JOIN post_count_read_models rm ON rm.post_id=ps.post_id WHERE ps.source_likes<>rm.like_count
  UNION ALL SELECT 'post_comment', ps.post_id::text, (ps.source_comments - rm.comment_count)::text FROM post_source ps JOIN post_count_read_models rm ON rm.post_id=ps.post_id WHERE ps.source_comments<>rm.comment_count
  UNION ALL SELECT 'follower', fs.user_id::text, (fs.source_followers - rm.follower_count)::text FROM follower_source fs JOIN user_count_read_models rm ON rm.user_id=fs.user_id WHERE fs.source_followers<>rm.follower_count
  UNION ALL SELECT 'unread', us.user_id::text, (us.source_unread - rm.unread_count)::text FROM unread_source us JOIN notification_count_read_models rm ON rm.user_id=us.user_id WHERE us.source_unread<>rm.unread_count
), checks AS (
  SELECT 'source_like_count' contract_name, 'post:101' subject_id, source_likes::text observed_value, 'Source likes ignore deleted reaction 1003' expected_reason FROM post_source WHERE post_id=101
  UNION ALL SELECT 'read_model_like_count','post:101',like_count::text,'Stored like counter is read-model state' FROM post_count_read_models WHERE post_id=101
  UNION ALL SELECT 'source_comment_count','post:101',source_comments::text,'Source comments ignore deleted comment 2002' FROM post_source WHERE post_id=101
  UNION ALL SELECT 'read_model_comment_count','post:101',comment_count::text,'Stored comment counter matches the read model row' FROM post_count_read_models WHERE post_id=101
  UNION ALL SELECT 'source_follower_count','user:2',source_followers::text,'Source followers count active follow_edges only' FROM follower_source WHERE user_id=2
  UNION ALL SELECT 'read_model_follower_count','user:2',follower_count::text,'Stored follower counter is stale for Ben' FROM user_count_read_models WHERE user_id=2
  UNION ALL SELECT 'unread_count','user:1',source_unread::text,'Source unread count excludes read notification 3003' FROM unread_source WHERE user_id=1
  UNION ALL SELECT 'drift_detected','all',COALESCE(string_agg(drift_type||':'||subject_id||':'||delta,'|' ORDER BY drift_type, subject_id),'none'),'Drift rows show source minus stored counter deltas' FROM drift
  UNION ALL SELECT 'no_drift_for_healthy_row','post:102',count(*)::text,'Post 102 stored counters match source counts' FROM post_source ps JOIN post_count_read_models rm ON rm.post_id=ps.post_id WHERE ps.post_id=102 AND ps.source_likes=rm.like_count AND ps.source_comments=rm.comment_count
  UNION ALL SELECT 'repair_candidate','all',COALESCE(string_agg(drift_type||':'||subject_id,'|' ORDER BY drift_type, subject_id),'none'),'Repair candidates are the rows with non-zero drift' FROM drift
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
