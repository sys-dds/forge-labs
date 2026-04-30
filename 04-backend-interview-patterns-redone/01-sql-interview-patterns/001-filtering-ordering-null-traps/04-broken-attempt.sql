SET search_path TO bip_sql_001;
SELECT listing_id, title, price_cents, quality_score
FROM listings
WHERE city = 'Glasgow'
ORDER BY price_cents ASC
LIMIT 3;
