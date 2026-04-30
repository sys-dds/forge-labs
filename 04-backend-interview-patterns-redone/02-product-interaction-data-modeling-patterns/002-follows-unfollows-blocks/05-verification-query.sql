SET search_path TO bip_pim_002;
WITH active_follows AS (
  SELECT f.* FROM follow_edges f
  LEFT JOIN block_edges b1 ON b1.blocker_user_id=f.followee_user_id AND b1.blocked_user_id=f.follower_user_id
  LEFT JOIN block_edges b2 ON b2.blocker_user_id=f.follower_user_id AND b2.blocked_user_id=f.followee_user_id
  WHERE f.status='active' AND b1.blocker_user_id IS NULL AND b2.blocker_user_id IS NULL
), checks AS (
  SELECT 'active_follow_edge' AS contract_name, '1->2' AS subject_id, COUNT(*)::text AS observed_value, 'Ada actively follows Ben' AS expected_reason FROM active_follows WHERE follower_user_id=1 AND followee_user_id=2
  UNION ALL SELECT 'one_way_follow_not_friendship','2->1',COUNT(*)::text,'Ben does not automatically follow Ada' FROM active_follows WHERE follower_user_id=2 AND followee_user_id=1
  UNION ALL SELECT 'unfollow_removed_from_active_count','3->2',COUNT(*)::text,'Cy inactive follow does not count for Ben' FROM active_follows WHERE follower_user_id=3 AND followee_user_id=2
  UNION ALL SELECT 'block_overrides_follow','4->2',COUNT(*)::text,'Ben block suppresses Omar follow' FROM active_follows WHERE follower_user_id=4 AND followee_user_id=2
  UNION ALL SELECT 'follower_count','Ben',COUNT(*)::text,'Ben follower count excludes inactive and blocked edges' FROM active_follows WHERE followee_user_id=2
  UNION ALL SELECT 'following_count','Ben',COUNT(*)::text,'Ben following count excludes blocked edges' FROM active_follows WHERE follower_user_id=2
  UNION ALL SELECT 'visible_author_check','viewer_4_post_201',COUNT(*)::text,'Blocked Omar cannot see Ben author row' FROM posts p LEFT JOIN block_edges b ON b.blocker_user_id=p.author_user_id AND b.blocked_user_id=4 WHERE p.post_id=201 AND b.blocker_user_id IS NULL
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
