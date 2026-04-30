CREATE OR REPLACE VIEW gauntlet_result AS
WITH RECURSIVE tree AS (
  SELECT id, post_id, parent_id, 0 AS depth, lpad(id::text, 3, '0') AS path FROM comments WHERE post_id=100 AND parent_id IS NULL
  UNION ALL
  SELECT c.id, c.post_id, c.parent_id, tree.depth + 1, tree.path || '.' || lpad(c.id::text, 3, '0')
  FROM comments c JOIN tree ON c.parent_id=tree.id
  WHERE c.post_id=100
)
SELECT id, post_id, depth, path FROM tree ORDER BY path;
