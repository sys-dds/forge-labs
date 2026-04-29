-- DENSE_RANK does not leave gaps, which is useful for grouped bands of authors.
CREATE VIEW author_follower_counts AS SELECT u.id, u.handle, count(f.follower_id) AS follower_count FROM users u LEFT JOIN follows f ON f.followee_id=u.id GROUP BY u.id,u.handle;
CREATE VIEW dense_ranked_authors AS SELECT handle, follower_count, dense_rank() OVER (ORDER BY follower_count DESC) AS follower_dense_rank FROM author_follower_counts;
