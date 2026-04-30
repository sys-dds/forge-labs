SET search_path TO bip_pim_008;
WITH visible_activity AS (
  SELECT viewer.user_id AS viewer_id, e.event_id, e.created_at FROM users viewer JOIN activity_events e ON true JOIN users actor ON actor.user_id=e.actor_user_id AND actor.status='active' JOIN visibility_rules vr ON vr.audience=e.audience LEFT JOIN posts p ON p.post_id=e.object_id AND e.object_type='post' LEFT JOIN follow_edges f ON f.follower_user_id=viewer.user_id AND f.followed_user_id=e.actor_user_id AND f.state='active' LEFT JOIN block_edges b1 ON b1.blocker_user_id=e.actor_user_id AND b1.blocked_user_id=viewer.user_id LEFT JOIN block_edges b2 ON b2.blocker_user_id=viewer.user_id AND b2.blocked_user_id=e.actor_user_id
  WHERE (e.object_type <> 'post' OR p.deleted_at IS NULL) AND b1.blocker_user_id IS NULL AND b2.blocker_user_id IS NULL AND ((viewer.user_id=e.actor_user_id AND vr.owner_visible) OR (viewer.user_id<>e.actor_user_id AND vr.follower_visible AND f.follower_user_id IS NOT NULL) OR (viewer.user_id<>e.actor_user_id AND e.audience='public'))
), checks AS (
  SELECT 'public_activity_visible' contract_name, 'viewer:1 event:8001' subject_id, count(*)::text observed_value, 'Ada can see Ben public activity while it remains public or followed-visible' expected_reason FROM visible_activity WHERE viewer_id=1 AND event_id=8001
  UNION ALL SELECT 'private_activity_hidden','viewer:1 event:8002',count(*)::text,'Ben private activity is hidden from Ada' FROM visible_activity WHERE viewer_id=1 AND event_id=8002
  UNION ALL SELECT 'owner_private_activity_visible','viewer:2 event:8002',count(*)::text,'Ben can see his own private activity' FROM visible_activity WHERE viewer_id=2 AND event_id=8002
  UNION ALL SELECT 'blocked_viewer_activity_hidden','viewer:3 actor:2',count(*)::text,'Cy follows Ben but Ben blocked Cy' FROM visible_activity WHERE viewer_id=3 AND event_id=8001
  UNION ALL SELECT 'deleted_object_activity_hidden','event:8004',count(*)::text,'Activity for deleted post 701 is hidden' FROM visible_activity WHERE event_id=8004
  UNION ALL SELECT 'activity_order','viewer:1',COALESCE(string_agg(event_id::text,'>' ORDER BY created_at DESC, event_id DESC),'none'),'Visible activity order is created_at desc then event_id desc' FROM visible_activity WHERE viewer_id=1
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
