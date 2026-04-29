-- The same recursive pattern works for categories, folders, and org charts.
CREATE VIEW category_tree AS WITH RECURSIVE tree AS (SELECT id,parent_id,name,0 AS depth,name::text AS path FROM categories WHERE parent_id IS NULL UNION ALL SELECT c.id,c.parent_id,c.name,t.depth+1,t.path || ' > ' || c.name FROM categories c JOIN tree t ON c.parent_id=t.id) SELECT * FROM tree ORDER BY path;
