CREATE OR REPLACE VIEW gauntlet_result AS
WITH RECURSIVE tree AS (
  SELECT id, post_id, parent_id, 0 AS depth, id::text AS path FROM comments WHERE parent_id IS NULL
  UNION ALL
  SELECT c.id, c.post_id, c.parent_id, tree.depth + 1, tree.path || '.' || c.id FROM comments c JOIN tree ON c.parent_id=tree.id
)
SELECT id, post_id, depth, path FROM tree ORDER BY path;
