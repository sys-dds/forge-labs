CREATE VIEW window_ranking_capstone AS
SELECT 'latest' AS kind, post_id::text AS value FROM latest_post_per_user
UNION ALL SELECT 'ranked', post_id || ':' || engagement_rank FROM ranked_posts
UNION ALL SELECT 'dense_author', handle || ':' || follower_dense_rank FROM dense_ranked_authors
ORDER BY kind, value;

