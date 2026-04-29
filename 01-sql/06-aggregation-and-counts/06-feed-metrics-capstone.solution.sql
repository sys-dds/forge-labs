CREATE VIEW feed_metrics_capstone AS
SELECT m.handle, m.visible_posts, m.visible_likes, m.visible_comments, f.follower_count
FROM author_metrics m JOIN follower_counts f ON f.handle = m.handle
ORDER BY m.handle;

