SET search_path TO bip_sql_005;
WITH ranked AS (
  SELECT topic, post_id, title, score,
         ROW_NUMBER() OVER (PARTITION BY topic ORDER BY score DESC, post_id ASC) AS topic_rank
  FROM posts
  WHERE unsafe = false
    AND deleted_at IS NULL
)
SELECT topic, post_id, title, score, topic_rank
FROM ranked
WHERE topic_rank <= 2
ORDER BY topic, topic_rank, post_id;
