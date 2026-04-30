SET search_path TO bip_pim_010;
WITH raw_join AS (SELECT u.user_id, p.post_id, n.notification_id, e.event_id FROM users u LEFT JOIN posts p ON true LEFT JOIN notifications n ON n.recipient_user_id=1 LEFT JOIN activity_events e ON true WHERE u.user_id<>1), raw_counts AS (SELECT count(*) AS row_count FROM raw_join), checks AS (
  SELECT 'profile_contract' contract_name, 'viewer:1' subject_id, COALESCE(string_agg(DISTINCT user_id::text,'|' ORDER BY user_id::text),'none') observed_value, 'Broken raw join leaks blocked and inactive profiles' expected_reason FROM raw_join
  UNION ALL SELECT 'follow_contract','Ada->Ben',count(*)::text,'Broken raw join duplicates follow facts' FROM raw_join WHERE user_id=2
  UNION ALL SELECT 'post_counts_contract','post:1001',((SELECT count(*) FROM post_reactions WHERE post_id=1001)::text||' likes/'||(SELECT count(*) FROM comments WHERE post_id=1001)::text||' comments'),'Broken counts deleted reactions/comments' FROM raw_counts
  UNION ALL SELECT 'match_contract','Ada-Diya',(SELECT count(*)::text FROM swipe_events WHERE swiper_user_id = 1 OR swiper_user_id = 4),'Broken counts swipes instead of active canonical match' FROM raw_counts
  UNION ALL SELECT 'notification_contract','recipient:1',(SELECT count(*)::text FROM notifications WHERE recipient_user_id=1),'Broken counts read notifications' FROM raw_counts
  UNION ALL SELECT 'activity_contract','viewer:1',COALESCE(string_agg(DISTINCT event_id::text,'|' ORDER BY event_id::text),'none'),'Broken leaks all activity events' FROM raw_join
  UNION ALL SELECT 'home_feed_contract','viewer:1',COALESCE(string_agg(DISTINCT post_id::text,'|' ORDER BY post_id::text),'none'),'Broken leaks global posts' FROM raw_join
  UNION ALL SELECT 'recommendation_contract','viewer:1',COALESCE(string_agg(DISTINCT user_id::text,'|' ORDER BY user_id::text),'none'),'Broken recommends every user' FROM raw_join
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
