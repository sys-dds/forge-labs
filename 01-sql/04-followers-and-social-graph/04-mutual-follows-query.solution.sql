-- A mutual follow is not a special row. It is two directed edges in opposite
-- directions. Ben is the only authored mutual follow for Ada.
CREATE VIEW ada_mutual_follows AS
SELECT followed.id, followed.handle
FROM follows AS ada_edge
JOIN follows AS return_edge
  ON return_edge.follower_id = ada_edge.followee_id
 AND return_edge.followee_id = ada_edge.follower_id
JOIN users AS followed
  ON followed.id = ada_edge.followee_id
WHERE ada_edge.follower_id = 1
ORDER BY followed.handle;

