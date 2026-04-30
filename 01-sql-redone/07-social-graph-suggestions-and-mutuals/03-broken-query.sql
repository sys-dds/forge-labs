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
JOIN users followed ON followed.id = outgoing.followee_id
WHERE ada.handle = 'ada'
ORDER BY followed.handle;

CREATE VIEW ada_safe_suggestions AS
SELECT candidate.handle
FROM users ada
JOIN follows either_edge ON either_edge.follower_id = ada.id OR either_edge.followee_id = ada.id
JOIN follows reachable ON reachable.follower_id = either_edge.followee_id OR reachable.followee_id = either_edge.follower_id
JOIN users candidate ON candidate.id = reachable.followee_id OR candidate.id = reachable.follower_id
WHERE ada.handle = 'ada'
  AND candidate.id <> ada.id
ORDER BY candidate.handle;

