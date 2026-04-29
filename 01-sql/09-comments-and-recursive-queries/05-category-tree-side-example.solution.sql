CREATE VIEW electronics_category_tree AS
WITH RECURSIVE tree AS (
  SELECT id, parent_id, name, 0 AS depth, name AS path FROM categories WHERE name = 'Electronics'
  UNION ALL
  SELECT c.id, c.parent_id, c.name, tree.depth + 1, tree.path || ' > ' || c.name
  FROM categories c JOIN tree ON tree.id = c.parent_id
)
SELECT id, name, depth, path FROM tree ORDER BY path;

