SET search_path TO bip_sql_003;
SELECT c.creator_id, c.creator_name,
       COUNT(p.post_id) AS published_posts,
       COUNT(CASE WHEN p.engagement_count >= 10 THEN 1 END) AS meaningful_posts
FROM creators c
JOIN posts p ON p.creator_id = c.creator_id
WHERE p.status = 'published'
  AND p.deleted_at IS NULL
GROUP BY c.creator_id, c.creator_name
HAVING COUNT(p.post_id) >= 3
   AND COUNT(CASE WHEN p.engagement_count >= 10 THEN 1 END) >= 2
ORDER BY c.creator_id;
