-- Capstone view collects the authored graph outputs so study mode can compare
-- the same dataset through four different traversals.
CREATE VIEW ada_social_graph_capstone AS
SELECT 'followers' AS result_set, handle FROM ada_followers
UNION ALL SELECT 'following', handle FROM ada_following
UNION ALL SELECT 'mutual', handle FROM ada_mutual_follows
UNION ALL SELECT 'suggestions', handle FROM ada_follow_suggestions
ORDER BY result_set, handle;

