CREATE OR REPLACE VIEW gauntlet_result AS
SELECT DISTINCT candidate.handle AS suggested_handle
FROM users AS ada
JOIN follows AS first_hop ON first_hop.follower_id = ada.id
JOIN follows AS second_hop ON second_hop.follower_id = first_hop.followee_id
JOIN users AS candidate ON candidate.id = second_hop.followee_id
WHERE ada.handle = 'ada'
  AND candidate.id <> ada.id
  AND NOT EXISTS (SELECT 1 FROM follows f WHERE f.follower_id=ada.id AND f.followee_id=candidate.id)
  AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id=ada.id AND b.blocked_id=candidate.id)
ORDER BY candidate.handle;
