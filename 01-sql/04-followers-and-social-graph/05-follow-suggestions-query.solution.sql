-- Follow suggestions are second-degree traversal:
-- 1. Start with people Ada follows: Ben and Cy.
-- 2. Look at who those people follow: Diya and Noor.
-- 3. Exclude Ada herself.
-- 4. Exclude users Ada already follows.
-- 5. Exclude users Ada blocks.
-- Noor is reachable through Cy, but the block predicate is the safety line.
CREATE VIEW ada_follow_suggestions AS
SELECT DISTINCT suggested.id, suggested.handle
FROM follows AS ada_edges
JOIN follows AS second_degree_edges
  ON second_degree_edges.follower_id = ada_edges.followee_id
JOIN users AS suggested
  ON suggested.id = second_degree_edges.followee_id
WHERE ada_edges.follower_id = 1
  AND suggested.id <> 1
  AND NOT EXISTS (
    SELECT 1 FROM follows AS already
    WHERE already.follower_id = 1
      AND already.followee_id = suggested.id
  )
  AND NOT EXISTS (
    SELECT 1 FROM blocks AS blocked
    WHERE blocked.blocker_id = 1
      AND blocked.blocked_id = suggested.id
  )
ORDER BY suggested.handle;

