SET search_path TO bip_pim_007;
WITH raw_notifications AS (SELECT event_id, actor_user_id, event_type, subject_type, subject_id, CASE WHEN event_type IN ('liked','commented') THEN 1 WHEN event_type='followed' THEN subject_id WHEN event_type='matched' THEN 1 END AS recipient_user_id FROM interaction_events), checks AS (
  SELECT 'like_notification_created' contract_name, 'post:201 actor:2' subject_id, count(*)::text observed_value, 'Broken raw events create duplicate like notifications' expected_reason FROM raw_notifications WHERE recipient_user_id=1 AND actor_user_id=2 AND event_type='liked' AND subject_id=201
  UNION ALL SELECT 'comment_notification_created','comment:301',count(*)::text,'Broken still has comment event' FROM raw_notifications WHERE recipient_user_id=1 AND actor_user_id=3 AND event_type='commented'
  UNION ALL SELECT 'follow_notification_created','follow:5->1',count(*)::text,'Broken still has follow event' FROM raw_notifications WHERE recipient_user_id=1 AND actor_user_id=5 AND event_type='followed'
  UNION ALL SELECT 'match_notification_created','match:401',count(*)::text,'Broken creates only one match recipient' FROM raw_notifications WHERE event_type='matched' AND subject_id=401
  UNION ALL SELECT 'self_notification_suppressed','event:1005',count(*)::text,'Broken leaks self notification' FROM raw_notifications WHERE event_id=1005
  UNION ALL SELECT 'duplicate_notification_deduped','Ben post 201 likes',count(*)::text,'Broken counts both Ben like events' FROM raw_notifications WHERE recipient_user_id=1 AND actor_user_id=2 AND event_type='liked' AND subject_id=201
  UNION ALL SELECT 'unread_count','recipient:1',count(*)::text,'Broken treats every raw event as unread' FROM raw_notifications WHERE recipient_user_id=1
  UNION ALL SELECT 'grouped_notification_summary','recipient:1 post:201',COALESCE(string_agg(event_type||':'||actor_user_id::text||':1','|' ORDER BY event_type, actor_user_id, event_id),'none'),'Broken summary is raw event rows' FROM raw_notifications WHERE recipient_user_id=1 AND subject_type IN ('post','comment')
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
