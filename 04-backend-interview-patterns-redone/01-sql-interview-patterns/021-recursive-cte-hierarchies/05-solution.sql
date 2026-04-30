SET search_path TO bip_sql_021;
WITH RECURSIVE tree AS (
  SELECT category_id, category_name, parent_category_id, 0 AS depth, category_name AS path_text,
         category_name AS root_category, ARRAY[category_id] AS visited
  FROM categories
  WHERE category_name = 'services' AND active = true
  UNION ALL
  SELECT c.category_id, c.category_name, c.parent_category_id, t.depth + 1,
         t.path_text || ' > ' || c.category_name, t.root_category, t.visited || c.category_id
  FROM tree t
  JOIN categories c ON c.parent_category_id = t.category_id
  WHERE c.active = true AND NOT c.category_id = ANY(t.visited) AND t.depth < 10
)
SELECT category_id, category_name, depth, path_text, root_category
FROM tree
ORDER BY path_text, category_id;
