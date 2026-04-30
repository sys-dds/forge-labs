SET search_path TO bip_sql_003;
SELECT c.creator_id, c.creator_name,
       COUNT(*) AS published_posts,
       COUNT(*) AS meaningful_posts
FROM creators c
JOIN posts p ON p.creator_id = c.creator_id
GROUP BY c.creator_id, c.creator_name
HAVING COUNT(*) >= 3
ORDER BY c.creator_id;
