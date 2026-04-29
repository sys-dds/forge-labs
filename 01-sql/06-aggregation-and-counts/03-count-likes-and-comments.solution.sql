-- Engagement counts should exclude deleted and hidden rows according to product rules.
CREATE VIEW post_engagement_counts AS SELECT p.id, count(DISTINCT l.user_id) AS like_count, count(DISTINCT c.id) FILTER (WHERE c.deleted=false) AS comment_count FROM posts p LEFT JOIN likes l ON l.post_id=p.id LEFT JOIN comments c ON c.post_id=p.id WHERE p.hidden=false GROUP BY p.id;
