SET search_path TO bip_pim_012;
WITH visible_posts AS (
  SELECT p.post_id FROM posts p JOIN users author ON author.user_id=p.author_user_id AND author.status='active'
  LEFT JOIN friendships fr ON fr.user_id_low=LEAST(1,p.author_user_id) AND fr.user_id_high=GREATEST(1,p.author_user_id) AND fr.state='accepted'
  LEFT JOIN audience_group_members agm ON agm.group_id=p.audience_group_id AND agm.member_user_id=1
  LEFT JOIN block_edges b1 ON b1.blocker_user_id=p.author_user_id AND b1.blocked_user_id=1
  LEFT JOIN block_edges b2 ON b2.blocker_user_id=1 AND b2.blocked_user_id=p.author_user_id
  WHERE p.deleted_at IS NULL AND b1.blocker_user_id IS NULL AND b2.blocker_user_id IS NULL AND (p.author_user_id=1 OR p.visibility='public' OR (p.visibility='friends_only' AND fr.user_id_low IS NOT NULL) OR (p.visibility='close_friends' AND agm.group_id IS NOT NULL))
), checks AS (
  SELECT 'public_visible' contract_name, 'post:201' subject_id, count(*)::text observed_value, 'Public Ben post is visible to Ada' expected_reason FROM visible_posts WHERE post_id=201
  UNION ALL SELECT 'private_hidden','post:202',count(*)::text,'Ben private post is hidden from non-owner Ada' FROM visible_posts WHERE post_id=202
  UNION ALL SELECT 'owner_private_visible','post:203',count(*)::text,'Ada can see her own private post' FROM visible_posts WHERE post_id=203
  UNION ALL SELECT 'friends_only_visible','post:204',count(*)::text,'Accepted friendship with Cy makes friends-only post visible' FROM visible_posts WHERE post_id=204
  UNION ALL SELECT 'close_friends_visible','post:205',count(*)::text,'Ada sees Diya close-friends post only while group member' FROM visible_posts WHERE post_id=205
  UNION ALL SELECT 'non_member_hidden','post:206',count(*)::text,'Ada is not in Eli close-friends group' FROM visible_posts WHERE post_id=206
  UNION ALL SELECT 'block_overrides_visibility','post:207',count(*)::text,'Omar blocked Ada so public visibility is overridden' FROM visible_posts WHERE post_id=207
  UNION ALL SELECT 'deleted_post_hidden','post:208',count(*)::text,'Deleted content is hidden regardless of public visibility' FROM visible_posts WHERE post_id=208
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
