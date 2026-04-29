CREATE VIEW post_engagement AS
SELECT p.id AS post_id, count(e.id) AS engagement_count
FROM posts p LEFT JOIN engagement_events e ON e.post_id = p.id
GROUP BY p.id;
CREATE VIEW ranked_posts AS
SELECT post_id, engagement_count, rank() OVER (ORDER BY engagement_count DESC) AS engagement_rank
FROM post_engagement ORDER BY engagement_rank, post_id;
