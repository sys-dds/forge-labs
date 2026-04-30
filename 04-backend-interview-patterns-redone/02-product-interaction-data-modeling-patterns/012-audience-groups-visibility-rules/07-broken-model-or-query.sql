SET search_path TO bip_pim_012;
WITH visible_posts AS (SELECT post_id FROM posts WHERE visibility <> 'private'), checks AS (
  SELECT 'public_visible' contract_name, 'post:201' subject_id, count(*)::text observed_value, 'Broken query allows non-private posts' expected_reason FROM visible_posts WHERE post_id=201
  UNION ALL SELECT 'private_hidden','post:202',count(*)::text,'Broken hides all private posts including owner cases' FROM visible_posts WHERE post_id=202
  UNION ALL SELECT 'owner_private_visible','post:203',count(*)::text,'Broken ignores owner private visibility' FROM visible_posts WHERE post_id=203
  UNION ALL SELECT 'friends_only_visible','post:204',count(*)::text,'Broken ignores accepted friendship evidence' FROM visible_posts WHERE post_id=204
  UNION ALL SELECT 'close_friends_visible','post:205',count(*)::text,'Broken ignores close-friends membership' FROM visible_posts WHERE post_id=205
  UNION ALL SELECT 'non_member_hidden','post:206',count(*)::text,'Broken leaks close-friends post to non-member' FROM visible_posts WHERE post_id=206
  UNION ALL SELECT 'block_overrides_visibility','post:207',count(*)::text,'Broken ignores block override' FROM visible_posts WHERE post_id=207
  UNION ALL SELECT 'deleted_post_hidden','post:208',count(*)::text,'Broken ignores deleted_at' FROM visible_posts WHERE post_id=208
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
