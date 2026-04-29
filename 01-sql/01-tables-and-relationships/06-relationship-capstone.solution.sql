-- The capstone view gathers one profile, many posts, optional settings, and many follow edges.
CREATE VIEW relationship_capstone AS
SELECT u.handle, p.display_name, count(DISTINCT posts.id) AS post_count, count(DISTINCT fp.followee_id) AS following_count, coalesce(s.email_notifications_enabled, false) AS has_enabled_email_notifications
FROM users u JOIN user_profiles p ON p.user_id = u.id LEFT JOIN posts ON posts.author_id = u.id LEFT JOIN follows_preview fp ON fp.follower_id = u.id LEFT JOIN user_settings s ON s.user_id = u.id
GROUP BY u.handle, p.display_name, s.email_notifications_enabled;
