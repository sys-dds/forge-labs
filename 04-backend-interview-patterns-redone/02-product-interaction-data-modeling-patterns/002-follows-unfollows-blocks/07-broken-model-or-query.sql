SET search_path TO bip_pim_002;
WITH all_follows AS (SELECT * FROM follow_edges), checks AS (
  SELECT 'active_follow_edge' AS contract_name,'1->2' AS subject_id,COUNT(*)::text AS observed_value,'Ada actively follows Ben' AS expected_reason FROM all_follows WHERE follower_user_id=1 AND followee_user_id=2
  UNION ALL SELECT 'one_way_follow_not_friendship','2->1',COUNT(*)::text,'Ben does not automatically follow Ada' FROM all_follows WHERE follower_user_id=2 AND followee_user_id=1
  UNION ALL SELECT 'unfollow_removed_from_active_count','3->2',COUNT(*)::text,'Cy inactive follow does not count for Ben' FROM all_follows WHERE follower_user_id=3 AND followee_user_id=2
  UNION ALL SELECT 'block_overrides_follow','4->2',COUNT(*)::text,'Ben block suppresses Omar follow' FROM all_follows WHERE follower_user_id=4 AND followee_user_id=2
  UNION ALL SELECT 'follower_count','Ben',COUNT(*)::text,'Ben follower count excludes inactive and blocked edges' FROM all_follows WHERE followee_user_id=2
  UNION ALL SELECT 'following_count','Ben',COUNT(*)::text,'Ben following count excludes blocked edges' FROM all_follows WHERE follower_user_id=2
  UNION ALL SELECT 'visible_author_check','viewer_4_post_201',COUNT(*)::text,'Blocked Omar cannot see Ben author row' FROM posts WHERE post_id=201
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
