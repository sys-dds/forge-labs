-- NOT EXISTS reads like policy: keep the candidate only when no exclusion row exists.
CREATE VIEW anti_join_safe_followed_authors AS
SELECT followed.id, followed.handle
FROM follows f
JOIN users followed ON followed.id = f.followee_id
WHERE f.follower_id = 1
  AND NOT EXISTS (SELECT 1 FROM mutes m WHERE m.muter_id = 1 AND m.muted_id = followed.id)
  AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id = 1 AND b.blocked_id = followed.id)
ORDER BY followed.handle;

