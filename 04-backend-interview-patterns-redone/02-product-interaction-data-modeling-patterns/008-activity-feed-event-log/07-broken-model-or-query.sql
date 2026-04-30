SET search_path TO bip_pim_008;
WITH all_activity AS (SELECT 1 AS viewer_id, event_id, created_at FROM activity_events UNION ALL SELECT 2,event_id,created_at FROM activity_events UNION ALL SELECT 3,event_id,created_at FROM activity_events), checks AS (
  SELECT 'public_activity_visible' contract_name, 'viewer:1 event:8001' subject_id, count(*)::text observed_value, 'Broken query returns every event' expected_reason FROM all_activity WHERE viewer_id=1 AND event_id=8001
  UNION ALL SELECT 'private_activity_hidden','viewer:1 event:8002',count(*)::text,'Broken leaks private activity' FROM all_activity WHERE viewer_id=1 AND event_id=8002
  UNION ALL SELECT 'owner_private_activity_visible','viewer:2 event:8002',count(*)::text,'Broken includes owner private activity by accident' FROM all_activity WHERE viewer_id=2 AND event_id=8002
  UNION ALL SELECT 'blocked_viewer_activity_hidden','viewer:3 actor:2',count(*)::text,'Broken leaks blocked viewer activity' FROM all_activity WHERE viewer_id=3 AND event_id=8001
  UNION ALL SELECT 'deleted_object_activity_hidden','event:8004',count(*)::text,'Broken leaks deleted object activity' FROM all_activity WHERE event_id=8004
  UNION ALL SELECT 'activity_order','viewer:1',COALESCE(string_agg(event_id::text,'>' ORDER BY created_at DESC, event_id DESC),'none'),'Broken order includes hidden rows' FROM all_activity WHERE viewer_id=1
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
