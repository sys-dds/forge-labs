CREATE VIEW recursive_query_capstone AS
SELECT 'comment' AS kind, id, body AS label, depth, path FROM c1_recursive_thread
UNION ALL
SELECT 'category', id, name, depth, path FROM electronics_category_tree
ORDER BY kind, path;

