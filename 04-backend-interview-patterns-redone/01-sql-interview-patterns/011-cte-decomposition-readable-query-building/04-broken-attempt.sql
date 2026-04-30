SET search_path TO bip_sql_011;
SELECT s.seller_id, s.seller_name, COUNT(l.listing_id) AS active_listings,
       COUNT(*) FILTER (WHERE o.status = 'completed') AS completed_orders,
       0.00 AS cancellation_rate, 0.00 AS dispute_rate, s.avg_response_minutes,
       COUNT(i.impression_id) AS recent_impressions, 'eligible' AS eligibility_reason
FROM sellers s
JOIN listings l ON l.seller_id = s.seller_id AND l.status = 'active'
JOIN listing_impressions i ON i.listing_id = l.listing_id AND i.impression_at >= DATE '2026-01-26'
JOIN orders o ON o.seller_id = s.seller_id
WHERE s.active = true
GROUP BY s.seller_id, s.seller_name, s.avg_response_minutes
HAVING COUNT(l.listing_id) >= 3 AND COUNT(*) FILTER (WHERE o.status = 'completed') >= 5
ORDER BY s.seller_id;
