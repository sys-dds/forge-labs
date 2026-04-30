CREATE VIEW ada_feed AS
WITH candidate_posts AS (
  SELECT p.id, p.author_id, p.created_at
  FROM users viewer
  JOIN follows f ON f.follower_id = viewer.id
  JOIN posts p ON p.author_id = f.followed_id
  WHERE viewer.handle = 'ada'
    AND p.is_hidden = false
    AND NOT EXISTS (
      SELECT 1 FROM mutes m
      WHERE m.muter_id = viewer.id AND m.muted_id = p.author_id
    )
    AND NOT EXISTS (
      SELECT 1 FROM blocks b
      WHERE b.blocker_id = viewer.id AND b.blocked_id = p.author_id
    )
),
like_counts AS (
  SELECT post_id, COUNT(*) AS like_count
  FROM post_likes
  GROUP BY post_id
),
comment_counts AS (
  SELECT post_id, COUNT(*) AS comment_count
  FROM comments
  GROUP BY post_id
)
SELECT
  cp.id AS post_id,
  author.handle AS author_handle,
  COALESCE(lc.like_count, 0) AS like_count,
  COALESCE(cc.comment_count, 0) AS comment_count,
  cp.created_at
FROM candidate_posts cp
JOIN users author ON author.id = cp.author_id
LEFT JOIN like_counts lc ON lc.post_id = cp.id
LEFT JOIN comment_counts cc ON cc.post_id = cp.id
ORDER BY cp.created_at DESC, cp.id DESC;

