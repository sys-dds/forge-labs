CREATE OR REPLACE VIEW gauntlet_profile_card AS
WITH post_counts AS (SELECT author_id, count(*)::integer AS post_count FROM posts GROUP BY author_id),
follower_counts AS (SELECT followee_id, count(*)::integer AS follower_count FROM follows GROUP BY followee_id),
following_counts AS (SELECT follower_id, count(*)::integer AS following_count FROM follows GROUP BY follower_id)
SELECT u.handle, p.display_name, coalesce(pc.post_count,0) AS post_count, coalesce(fc.follower_count,0) AS follower_count, coalesce(fgc.following_count,0) AS following_count
FROM users u
JOIN profiles p ON p.user_id=u.id
LEFT JOIN post_counts pc ON pc.author_id=u.id
LEFT JOIN follower_counts fc ON fc.followee_id=u.id
LEFT JOIN following_counts fgc ON fgc.follower_id=u.id
WHERE u.handle='ada';

CREATE OR REPLACE VIEW gauntlet_search_results AS
SELECT u.handle FROM users u JOIN profiles p ON p.user_id=u.id WHERE p.searchable ORDER BY u.handle;
