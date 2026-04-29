-- Safety rules still support useful reads.
CREATE VIEW constraint_capstone AS SELECT u.handle, count(f.followee_id) AS following_count FROM users u LEFT JOIN follows f ON f.follower_id = u.id GROUP BY u.handle;
