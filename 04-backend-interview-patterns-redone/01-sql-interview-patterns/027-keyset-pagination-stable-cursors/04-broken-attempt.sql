SET search_path TO bip_sql_027;
SELECT listing_id, ranking_score
FROM listings
WHERE blocked=false
ORDER BY ranking_score DESC, listing_id ASC
OFFSET 2 LIMIT 3;
