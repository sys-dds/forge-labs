CREATE VIEW ada_creator_discovery_page_one AS
SELECT
  candidate.id AS creator_id,
  candidate.handle,
  candidate.email,
  profile_rows.display_name,
  COUNT(follower_rows.follower_id) AS follower_count,
  COUNT(mutual_rows.follower_id) AS mutual_follow_count,
  COUNT(post_rows.id) AS recent_visible_post_count,
  'raw user row' AS reason_label,
  MAX(post_rows.created_at) AS cursor_created_at,
  candidate.id AS cursor_creator_id
FROM users ada
JOIN users candidate ON true
JOIN profiles profile_rows ON profile_rows.user_id = candidate.id
LEFT JOIN posts post_rows ON post_rows.author_id = candidate.id
LEFT JOIN follows follower_rows ON follower_rows.followee_id = candidate.id
LEFT JOIN follows ada_following ON ada_following.follower_id = ada.id
LEFT JOIN follows mutual_rows ON mutual_rows.follower_id = ada_following.followee_id
  AND mutual_rows.followee_id = candidate.id
WHERE ada.handle = 'ada'
GROUP BY candidate.id, candidate.handle, candidate.email, profile_rows.display_name
ORDER BY recent_visible_post_count DESC, follower_count DESC, cursor_created_at DESC NULLS LAST
LIMIT 10;

