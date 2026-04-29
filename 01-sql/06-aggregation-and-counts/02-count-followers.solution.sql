CREATE VIEW follower_counts AS
SELECT u.handle, count(f.follower_id) AS follower_count
FROM users u LEFT JOIN follows f ON f.followee_id = u.id
GROUP BY u.handle ORDER BY u.handle;

