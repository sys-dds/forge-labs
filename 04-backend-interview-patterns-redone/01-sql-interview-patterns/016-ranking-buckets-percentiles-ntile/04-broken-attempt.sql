SET search_path TO bip_sql_016;
SELECT creator_id, creator_name, follower_count AS computed_score,
       RANK() OVER (ORDER BY follower_count DESC) AS rank_position,
       NTILE(4) OVER (ORDER BY follower_count DESC, creator_id) AS quality_bucket
FROM creators
ORDER BY quality_bucket, rank_position, creator_id;
