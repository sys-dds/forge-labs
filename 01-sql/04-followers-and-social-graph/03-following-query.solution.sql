-- Following walks the edge forwards: who did Ada choose as followee_id?
CREATE VIEW ada_following AS
SELECT u.id, u.handle
FROM follows AS edge
JOIN users AS u ON u.id = edge.followee_id
WHERE edge.follower_id = 1
ORDER BY u.handle;

