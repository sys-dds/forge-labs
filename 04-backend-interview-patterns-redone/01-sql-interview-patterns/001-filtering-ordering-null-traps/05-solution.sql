SET search_path TO bip_sql_001;
SELECT listing_id, title, price_cents, quality_score
FROM listings
WHERE city = 'Glasgow'
  AND status = 'available'
  AND blocked_at IS NULL
  AND price_cents IS NOT NULL
ORDER BY quality_score DESC, price_cents ASC, listing_id ASC
LIMIT 3;
