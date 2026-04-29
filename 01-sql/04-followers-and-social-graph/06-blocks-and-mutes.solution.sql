-- Blocks and mutes are intentionally separate relationships.
-- A block is a safety exclusion: the user should not be suggested or shown.
-- A mute is a feed preference: Ada still follows Linus, but Linus should not
-- appear in feed-like candidate lists until the mute is removed.
CREATE VIEW ada_feed_visible_following AS
SELECT
  followed.id,
  followed.handle
FROM follows AS ada_edges
JOIN users AS followed
  ON followed.id = ada_edges.followee_id
WHERE ada_edges.follower_id = 1
  AND NOT EXISTS (
    SELECT 1
    FROM blocks AS blocked
    WHERE blocked.blocker_id = 1
      AND blocked.blocked_id = ada_edges.followee_id
  )
  AND NOT EXISTS (
    SELECT 1
    FROM mutes AS muted
    WHERE muted.muter_id = 1
      AND muted.muted_id = ada_edges.followee_id
  )
ORDER BY followed.handle;
