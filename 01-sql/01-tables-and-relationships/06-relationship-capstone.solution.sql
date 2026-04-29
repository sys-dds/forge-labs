CREATE VIEW relationship_capstone AS
SELECT u.handle,
       count(DISTINCT p.id) AS post_count,
       (s.user_id IS NOT NULL) AS has_settings,
       count(DISTINCT f.followee_id) AS preview_following_count
FROM users u
LEFT JOIN posts p ON p.author_id = u.id
LEFT JOIN user_settings s ON s.user_id = u.id
LEFT JOIN follows_preview f ON f.follower_id = u.id
GROUP BY u.id, u.handle, s.user_id
ORDER BY u.handle;

