-- Follower counts are grouped by the user being followed.
CREATE VIEW follower_counts AS SELECT followee_id AS user_id, count(*) AS follower_count FROM follows GROUP BY followee_id;
