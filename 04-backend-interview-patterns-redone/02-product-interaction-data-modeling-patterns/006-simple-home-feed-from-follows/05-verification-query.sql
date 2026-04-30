SET search_path TO bip_pim_006;
WITH home_feed AS (
  SELECT p.post_id, p.author_user_id, p.created_at, row_number() OVER (ORDER BY p.created_at DESC, p.post_id DESC) AS position
  FROM posts p JOIN users author ON author.user_id=p.author_user_id AND author.status='active'
  JOIN follow_edges f ON f.followed_user_id=p.author_user_id AND f.follower_user_id=1 AND f.state='active'
  LEFT JOIN block_edges b ON b.blocker_user_id=1 AND b.blocked_user_id=p.author_user_id
  LEFT JOIN mute_edges m ON m.muter_user_id=1 AND m.muted_user_id=p.author_user_id
  WHERE p.deleted_at IS NULL AND b.blocker_user_id IS NULL AND m.muter_user_id IS NULL
), checks AS (
  SELECT 'followed_author_post_visible' contract_name, 'post:101' subject_id, count(*)::text observed_value, 'Ben is active followed unblocked unmuted and the post is live' expected_reason FROM home_feed WHERE post_id=101
  UNION ALL SELECT 'unfollowed_author_hidden','post:103',count(*)::text,'Eli is hidden unless the follow_edges row is active' FROM home_feed WHERE post_id=103
  UNION ALL SELECT 'blocked_author_hidden','post:104',count(*)::text,'Ada blocked Omar so his followed post is suppressed' FROM home_feed WHERE post_id=104
  UNION ALL SELECT 'muted_author_hidden','post:105',count(*)::text,'Ada muted Noor so her followed post is suppressed' FROM home_feed WHERE post_id=105
  UNION ALL SELECT 'deleted_post_hidden','post:106',count(*)::text,'Deleted posts do not enter the home feed' FROM home_feed WHERE post_id=106
  UNION ALL SELECT 'inactive_author_hidden','post:107',count(*)::text,'Posts from inactive Lina are hidden even with a follow edge' FROM home_feed WHERE post_id=107
  UNION ALL SELECT 'feed_order','viewer:1',COALESCE(string_agg(post_id::text,'>' ORDER BY position),'none'),'Feed order is created_at desc then post_id desc' FROM home_feed
  UNION ALL SELECT 'stable_cursor_order','after:102',COALESCE(string_agg(post_id::text,'>' ORDER BY created_at DESC, post_id DESC),'none'),'Cursor after post 102 keeps deterministic older rows' FROM home_feed WHERE (created_at, post_id) < ((SELECT created_at FROM posts WHERE post_id=102),102)
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
