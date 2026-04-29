-- Blocks and mutes are separate because they protect different product promises.
-- A block prevents unsafe recommendation. A mute hides feed-style output without
-- deleting the durable follow edge Ada created earlier.
CREATE VIEW ada_feed_visible_following AS
SELECT followed.id, followed.handle
FROM follows AS edge
JOIN users AS followed ON followed.id = edge.followee_id
WHERE edge.follower_id = 1
  AND NOT EXISTS (
    SELECT 1 FROM mutes AS muted
    WHERE muted.muter_id = 1
      AND muted.muted_id = followed.id
  )
  AND NOT EXISTS (
    SELECT 1 FROM blocks AS blocked
    WHERE blocked.blocker_id = 1
      AND blocked.blocked_id = followed.id
  )
ORDER BY followed.handle;

