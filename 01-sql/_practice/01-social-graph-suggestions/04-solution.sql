CREATE OR REPLACE VIEW ada_safe_suggestions AS
SELECT DISTINCT
  candidate.handle AS suggested_handle
FROM users AS ada
JOIN follows AS ada_follows
  ON ada_follows.follower_id = ada.id
JOIN follows AS second_hop
  ON second_hop.follower_id = ada_follows.followee_id
JOIN users AS candidate
  ON candidate.id = second_hop.followee_id
WHERE ada.handle = 'ada'
  AND candidate.id <> ada.id
  AND NOT EXISTS (
    SELECT 1
    FROM follows AS already_followed
    WHERE already_followed.follower_id = ada.id
      AND already_followed.followee_id = candidate.id
  )
  AND NOT EXISTS (
    SELECT 1
    FROM user_blocks AS blocked
    WHERE blocked.blocker_id = ada.id
      AND blocked.blocked_id = candidate.id
  )
ORDER BY candidate.handle;
