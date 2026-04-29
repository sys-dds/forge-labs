-- Followers walk the edge backwards: who has Ada as followee_id?
CREATE VIEW ada_followers AS
SELECT u.id, u.handle
FROM follows AS edge
JOIN users AS u ON u.id = edge.follower_id
WHERE edge.followee_id = 1
ORDER BY u.handle;

