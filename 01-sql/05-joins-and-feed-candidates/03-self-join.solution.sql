-- A self-join can compare authors through the same follows table. Here it marks
-- which followed authors are also blocked or muted by Ada.
CREATE VIEW followed_author_visibility AS
SELECT followed.handle,
       EXISTS (SELECT 1 FROM mutes m WHERE m.muter_id = 1 AND m.muted_id = followed.id) AS muted,
       EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id = 1 AND b.blocked_id = followed.id) AS blocked
FROM follows f
JOIN users followed ON followed.id = f.followee_id
WHERE f.follower_id = 1
ORDER BY followed.handle;

