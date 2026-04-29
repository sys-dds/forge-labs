-- Follow suggestions are second-degree graph traversal:
-- 1. Start with people Ada already follows.
-- 2. Look at who those people follow.
-- 3. Exclude Ada herself.
-- 4. Exclude users Ada already follows.
-- 5. Exclude blocked users because suggestions are a safety-sensitive surface.
-- DISTINCT matters because Grace and Linus can both point at the same suggestion.
CREATE VIEW ada_follow_suggestions AS
SELECT DISTINCT
  suggested.id,
  suggested.handle
FROM follows AS ada_edges
JOIN follows AS second_degree_edges
  ON second_degree_edges.follower_id = ada_edges.followee_id
JOIN users AS suggested
  ON suggested.id = second_degree_edges.followee_id
WHERE ada_edges.follower_id = 1
  AND suggested.id <> 1
  AND NOT EXISTS (
    SELECT 1
    FROM follows AS already_followed
    WHERE already_followed.follower_id = 1
      AND already_followed.followee_id = suggested.id
  )
  AND NOT EXISTS (
    SELECT 1
    FROM blocks AS blocked
    WHERE blocked.blocker_id = 1
      AND blocked.blocked_id = suggested.id
  )
ORDER BY suggested.handle;
