CREATE VIEW feed_ranking_inputs AS
SELECT p.id AS post_id, p.author_id, p.created_at,
       count(e.id) FILTER (WHERE e.event_type='like') AS like_count,
       count(e.id) FILTER (WHERE e.event_type='comment') AS comment_count,
       EXISTS (SELECT 1 FROM follows f WHERE f.follower_id = 1 AND f.followee_id = p.author_id) AS follows_author,
       count(e.id) AS raw_score_input
FROM posts p LEFT JOIN engagement_events e ON e.post_id = p.id
GROUP BY p.id ORDER BY p.created_at DESC, p.id DESC;

