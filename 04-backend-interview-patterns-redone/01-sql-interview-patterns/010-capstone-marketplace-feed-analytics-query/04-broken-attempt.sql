SET search_path TO bip_sql_010;
SELECT s.seller_id, s.seller_name, COUNT(e.event_id) AS recent_listing_impressions
FROM sellers s
JOIN listings l ON l.seller_id = s.seller_id
JOIN listing_events e ON e.listing_id = l.listing_id AND e.event_name = 'impression'
GROUP BY s.seller_id, s.seller_name
ORDER BY recent_listing_impressions DESC, s.seller_id;
