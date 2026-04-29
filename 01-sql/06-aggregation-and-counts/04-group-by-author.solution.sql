CREATE VIEW author_metrics AS
SELECT u.handle,
       count(DISTINCT p.id) FILTER (WHERE p.visible) AS visible_posts,
       count(DISTINCT l.user_id) FILTER (WHERE p.visible) AS visible_likes,
       count(DISTINCT c.id) FILTER (WHERE p.visible AND c.deleted = false) AS visible_comments
FROM users u
LEFT JOIN posts p ON p.author_id = u.id
LEFT JOIN likes l ON l.post_id = p.id
LEFT JOIN comments c ON c.post_id = p.id
GROUP BY u.handle ORDER BY u.handle;

