-- Feed candidate generation is the handoff from graph queries to ranking.
-- The query deliberately does not score posts yet. It only gathers posts Ada
-- is allowed to see, attaches author profile fields, and exposes relationship
-- metadata that later ranking code could use.
CREATE VIEW feed_candidates AS
SELECT
  p.id AS post_id,
  p.body,
  author.id AS author_id,
  author.handle,
  pr.display_name,
  true AS viewer_follows_author
FROM posts AS p
JOIN follows AS ada_edges
  ON ada_edges.followee_id = p.author_id
 AND ada_edges.follower_id = 1
JOIN users AS author
  ON author.id = p.author_id
JOIN profiles AS pr
  ON pr.user_id = author.id
WHERE NOT EXISTS (
    SELECT 1
    FROM blocks AS blocked
    WHERE blocked.blocker_id = 1
      AND blocked.blocked_id = p.author_id
  )
  AND NOT EXISTS (
    SELECT 1
    FROM mutes AS muted
    WHERE muted.muter_id = 1
      AND muted.muted_id = p.author_id
  )
ORDER BY p.id;
