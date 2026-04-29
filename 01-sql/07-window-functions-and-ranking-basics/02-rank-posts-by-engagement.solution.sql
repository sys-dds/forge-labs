-- RANK leaves gaps after ties, which is useful when tied scores should share a visible place.
CREATE VIEW post_engagement AS SELECT p.id, count(DISTINCT l.user_id)+count(DISTINCT c.id) AS engagement FROM posts p LEFT JOIN likes l ON l.post_id=p.id LEFT JOIN comments c ON c.post_id=p.id GROUP BY p.id;
CREATE VIEW ranked_posts AS SELECT id, engagement, rank() OVER (ORDER BY engagement DESC) AS engagement_rank FROM post_engagement;
