SET search_path TO bip_sql_005;
SELECT topic, post_id, title, score, 1 AS topic_rank
FROM posts
WHERE unsafe = false
  AND deleted_at IS NULL
ORDER BY score DESC, post_id ASC
LIMIT 2;
