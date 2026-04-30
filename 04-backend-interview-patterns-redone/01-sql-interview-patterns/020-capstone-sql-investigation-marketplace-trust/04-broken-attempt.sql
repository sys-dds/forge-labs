SET search_path TO bip_sql_020;
SELECT s.seller_id, s.seller_name, COUNT(DISTINCT l.listing_id) AS active_listings, 0 AS completed_orders,
       0.00 AS cancellation_rate, 0.00 AS dispute_rate, 0.00 AS refund_rate, 0.00 AS avg_response_minutes,
       COUNT(li.event_id) AS recent_impressions, 0.00 AS contact_rate, 0.00 AS booking_rate,
       'boost' AS treatment, 'many_impressions' AS primary_reason
FROM sellers s
JOIN listings l ON l.seller_id = s.seller_id
JOIN listing_impressions li ON li.listing_id = l.listing_id AND li.event_type = 'impression'
GROUP BY s.seller_id, s.seller_name
ORDER BY recent_impressions DESC, s.seller_id;
