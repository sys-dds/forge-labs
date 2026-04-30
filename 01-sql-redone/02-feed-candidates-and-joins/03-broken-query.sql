CREATE VIEW ada_feed AS
SELECT
  p.id AS post_id,
  author.handle AS author_handle,
  COUNT(pl.user_id) AS like_count,
  COUNT(c.id) AS comment_count,
  p.created_at
FROM users viewer
JOIN follows f ON f.follower_id = viewer.id
JOIN users author ON author.id = f.followed_id
JOIN posts p ON p.author_id = author.id
LEFT JOIN post_likes pl ON pl.post_id = p.id
JOIN comments c ON c.post_id = p.id
WHERE viewer.handle = 'ada'
GROUP BY p.id, author.handle, p.created_at
ORDER BY p.created_at DESC, p.id DESC;

