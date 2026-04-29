CREATE VIEW authors_with_more_than_one_visible_post AS
SELECT u.handle, count(p.id) AS visible_posts
FROM users u JOIN posts p ON p.author_id = u.id
WHERE p.visible
GROUP BY u.handle
HAVING count(p.id) > 1
ORDER BY u.handle;

