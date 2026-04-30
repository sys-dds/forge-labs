SET search_path TO bip_pim_015;
WITH raw_view AS (SELECT u.user_id, p.post_id, b.bookmark_id, r.repost_id FROM users u LEFT JOIN posts p ON true LEFT JOIN bookmarks b ON true LEFT JOIN reposts r ON true WHERE u.user_id<>1), checks AS (
  SELECT 'profile_visibility_contract' contract_name, 'viewer:1' subject_id, COALESCE(string_agg(DISTINCT user_id::text,'|' ORDER BY user_id::text),'none') observed_value, 'Broken raw join leaks blocked and unrelated profiles' expected_reason FROM raw_view
  UNION ALL SELECT 'post_visibility_contract','viewer:1',COALESCE(string_agg(DISTINCT post_id::text,'|' ORDER BY post_id::text),'none'),'Broken raw join leaks private deleted controlled posts' FROM raw_view
  UNION ALL SELECT 'user_controls_contract','viewer:1',COALESCE(string_agg(DISTINCT post_id::text,'|' ORDER BY post_id::text),'none'),'Broken raw join ignores hide and mute controls' FROM raw_view
  UNION ALL SELECT 'share_save_contract','viewer:1',(SELECT count(*)::text FROM reposts)||' reposts/'||(SELECT count(*)::text FROM bookmarks)||' saves','Broken treats all reposts and saves as public ordinary rows' FROM raw_view
  UNION ALL SELECT 'post_counts_contract','post:501',(SELECT like_count::text||' likes/'||comment_count::text||' comments' FROM post_count_read_models WHERE post_id=501),'Broken trusts read-model post counters blindly' FROM raw_view
  UNION ALL SELECT 'follower_counts_contract','user:2',(SELECT follower_count::text FROM user_count_read_models WHERE user_id=2),'Broken trusts read-model follower counters blindly' FROM raw_view
  UNION ALL SELECT 'unread_counts_contract','user:1',(SELECT count(*)::text FROM notifications WHERE recipient_user_id=1),'Broken counts read notifications as unread' FROM raw_view
  UNION ALL SELECT 'drift_contract','all','none','Broken raw view never compares source and read-model counters' FROM raw_view
  UNION ALL SELECT 'repair_candidate_contract','all','none','Broken raw view never emits repair candidates' FROM raw_view
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
