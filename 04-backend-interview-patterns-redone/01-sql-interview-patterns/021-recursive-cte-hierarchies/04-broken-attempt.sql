SET search_path TO bip_sql_021;
SELECT c.category_id,c.category_name,1 AS depth,'services > ' || c.category_name AS path_text,'services' AS root_category
FROM categories r JOIN categories c ON c.parent_category_id=r.category_id
WHERE r.category_name='services' AND c.active=true
ORDER BY path_text;
