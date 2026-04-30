CREATE VIEW ben_public_profile_card AS
WITH visible_posts AS (
  SELECT author_id, COUNT(*) AS visible_post_count
  FROM posts
  WHERE is_hidden = false
  GROUP BY author_id
),
follower_counts AS (
  SELECT followee_id AS user_id, COUNT(*) AS follower_count
  FROM follows
  GROUP BY followee_id
),
following_counts AS (
  SELECT follower_id AS user_id, COUNT(*) AS following_count
  FROM follows
  GROUP BY follower_id
)
SELECT
  u.handle,
  p.display_name,
  p.bio,
  COALESCE(vp.visible_post_count, 0) AS visible_post_count,
  COALESCE(fc.follower_count, 0) AS follower_count,
  COALESCE(fgc.following_count, 0) AS following_count
FROM users u
JOIN profiles p ON p.user_id = u.id
LEFT JOIN visible_posts vp ON vp.author_id = u.id
LEFT JOIN follower_counts fc ON fc.user_id = u.id
LEFT JOIN following_counts fgc ON fgc.user_id = u.id
WHERE u.handle = 'ben';

CREATE VIEW ada_safe_profile_search AS
SELECT target.handle
FROM users ada
JOIN users target ON target.id <> ada.id
JOIN profiles profile_rows ON profile_rows.user_id = target.id
WHERE ada.handle = 'ada'
  AND profile_rows.is_searchable = true
  AND NOT EXISTS (
    SELECT 1 FROM blocks b
    WHERE b.blocker_id = ada.id AND b.blocked_id = target.id
  )
ORDER BY target.handle;

