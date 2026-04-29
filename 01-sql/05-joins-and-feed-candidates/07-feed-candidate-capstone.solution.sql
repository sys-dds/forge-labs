CREATE VIEW ada_feed_candidate_capstone AS
SELECT c.post_id, c.author_handle, e.like_count, e.comment_count
FROM ada_feed_candidates c
JOIN fixed_engagement_counts e ON e.post_id = c.post_id
ORDER BY c.post_id;

