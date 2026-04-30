SET search_path TO bip_pim_006;
WITH global_recent AS (SELECT post_id, created_at, row_number() OVER (ORDER BY created_at DESC, post_id DESC) AS position FROM posts), checks AS (
  SELECT 'followed_author_post_visible' contract_name, 'post:101' subject_id, count(*)::text observed_value, 'Broken query uses global recent posts instead of the follow graph' expected_reason FROM global_recent WHERE post_id=101
  UNION ALL SELECT 'unfollowed_author_hidden','post:103',count(*)::text,'Broken query leaks unfollowed posts' FROM global_recent WHERE post_id=103
  UNION ALL SELECT 'blocked_author_hidden','post:104',count(*)::text,'Broken query leaks blocked authors' FROM global_recent WHERE post_id=104
  UNION ALL SELECT 'muted_author_hidden','post:105',count(*)::text,'Broken query leaks muted authors' FROM global_recent WHERE post_id=105
  UNION ALL SELECT 'deleted_post_hidden','post:106',count(*)::text,'Broken query leaks deleted posts' FROM global_recent WHERE post_id=106
  UNION ALL SELECT 'inactive_author_hidden','post:107',count(*)::text,'Broken query leaks inactive authors' FROM global_recent WHERE post_id=107
  UNION ALL SELECT 'feed_order','viewer:1',COALESCE(string_agg(post_id::text,'>' ORDER BY position),'none'),'Broken order is global recent' FROM global_recent
  UNION ALL SELECT 'stable_cursor_order','after:102',COALESCE(string_agg(post_id::text,'>' ORDER BY created_at DESC, post_id DESC),'none'),'Broken cursor walks global posts' FROM global_recent WHERE (created_at, post_id) < ((SELECT created_at FROM posts WHERE post_id=102),102)
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
