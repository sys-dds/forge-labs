CREATE VIEW post_metrics AS
SELECT
  p.id AS post_id,
  a.handle AS author_handle,
  COUNT(pl.user_id) AS like_count,
  COUNT(c.id) AS comment_count
FROM posts p
JOIN authors a ON a.id = p.author_id
JOIN post_likes pl ON pl.post_id = p.id
JOIN comments c ON c.post_id = p.id
GROUP BY p.id, a.handle;

CREATE VIEW author_metrics AS
SELECT
  a.handle AS author_handle,
  COUNT(pm.post_id) AS visible_post_count,
  COALESCE(SUM(pm.like_count), 0) AS total_likes,
  COALESCE(SUM(pm.comment_count), 0) AS total_comments
FROM authors a
LEFT JOIN post_metrics pm ON pm.author_handle = a.handle
GROUP BY a.handle;

