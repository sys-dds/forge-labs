SET search_path TO bip_sql_016;
WITH scored AS (
  SELECT creator_id, creator_name,
         (completed_posts * 4 + avg_dwell_seconds / 10 + trust_score - report_count * 8 - hide_count * 3) AS computed_score
  FROM creators
), ranked AS (
  SELECT creator_id, creator_name, computed_score,
         RANK() OVER (ORDER BY computed_score DESC) AS rank_position,
         NTILE(4) OVER (ORDER BY computed_score DESC, creator_id) AS quality_bucket
  FROM scored
)
SELECT creator_id, creator_name, computed_score, rank_position, quality_bucket
FROM ranked
ORDER BY quality_bucket, rank_position, creator_id;
