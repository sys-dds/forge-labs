SET search_path TO bip_sql_027;
SELECT l.listing_id, l.ranking_score
FROM listings l CROSS JOIN page_cursor c
WHERE l.blocked=false
  AND (l.ranking_score < c.last_score OR (l.ranking_score = c.last_score AND l.listing_id > c.last_listing_id))
ORDER BY l.ranking_score DESC, l.listing_id ASC
LIMIT 3;
