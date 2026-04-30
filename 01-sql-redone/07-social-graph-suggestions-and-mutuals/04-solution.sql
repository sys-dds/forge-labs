CREATE VIEW ada_following AS
SELECT followed.handle
FROM users ada
JOIN follows f ON f.follower_id = ada.id
JOIN users followed ON followed.id = f.followee_id
WHERE ada.handle = 'ada'
ORDER BY followed.handle;

CREATE VIEW ada_followers AS
SELECT follower.handle
FROM users ada
JOIN follows f ON f.followee_id = ada.id
JOIN users follower ON follower.id = f.follower_id
WHERE ada.handle = 'ada'
ORDER BY follower.handle;

CREATE VIEW ada_mutual_follows AS
SELECT followed.handle
FROM users ada
JOIN follows outgoing ON outgoing.follower_id = ada.id
JOIN follows incoming ON incoming.follower_id = outgoing.followee_id
  AND incoming.followee_id = ada.id
JOIN users followed ON followed.id = outgoing.followee_id
WHERE ada.handle = 'ada'
ORDER BY followed.handle;

CREATE VIEW ada_safe_suggestions AS
SELECT DISTINCT candidate.handle
FROM users ada
JOIN follows first_hop ON first_hop.follower_id = ada.id
JOIN follows second_hop ON second_hop.follower_id = first_hop.followee_id
JOIN users candidate ON candidate.id = second_hop.followee_id
WHERE ada.handle = 'ada'
  AND candidate.id <> ada.id
  AND NOT EXISTS (
    SELECT 1 FROM follows already
    WHERE already.follower_id = ada.id AND already.followee_id = candidate.id
  )
  AND NOT EXISTS (
    SELECT 1 FROM blocks b
    WHERE b.blocker_id = ada.id AND b.blocked_id = candidate.id
  )
ORDER BY candidate.handle;

