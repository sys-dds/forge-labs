CREATE VIEW post_metrics AS
WITH like_counts AS (
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
  p.id AS post_id,
  a.handle AS author_handle,
  COALESCE(lc.like_count, 0) AS like_count,
  COALESCE(cc.comment_count, 0) AS comment_count
FROM posts p
JOIN authors a ON a.id = p.author_id
LEFT JOIN like_counts lc ON lc.post_id = p.id
LEFT JOIN comment_counts cc ON cc.post_id = p.id
WHERE p.is_hidden = false;

CREATE VIEW author_metrics AS
SELECT
  a.handle AS author_handle,
  COUNT(pm.post_id) AS visible_post_count,
  COALESCE(SUM(pm.like_count), 0) AS total_likes,
  COALESCE(SUM(pm.comment_count), 0) AS total_comments
FROM authors a
LEFT JOIN post_metrics pm ON pm.author_handle = a.handle
GROUP BY a.handle;

