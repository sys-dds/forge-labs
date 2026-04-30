SET search_path TO bip_sql_011;
WITH active_listing_counts AS (
  SELECT seller_id, COUNT(*) AS active_listings
  FROM listings
  WHERE status = 'active'
  GROUP BY seller_id
), order_metrics AS (
  SELECT seller_id,
         COUNT(*) FILTER (WHERE status = 'completed') AS completed_orders,
         ROUND(COUNT(*) FILTER (WHERE status = 'cancelled')::numeric / NULLIF(COUNT(*),0), 2) AS cancellation_rate,
         ROUND(COUNT(*) FILTER (WHERE disputed)::numeric / NULLIF(COUNT(*),0), 2) AS dispute_rate
  FROM orders
  GROUP BY seller_id
), recent_impressions AS (
  SELECT l.seller_id, COUNT(*) AS recent_impressions
  FROM listings l
  JOIN listing_impressions i ON i.listing_id = l.listing_id
  WHERE i.impression_at >= DATE '2026-01-26'
  GROUP BY l.seller_id
), eligibility AS (
  SELECT s.seller_id, s.seller_name, COALESCE(a.active_listings,0) AS active_listings,
         COALESCE(o.completed_orders,0) AS completed_orders,
         COALESCE(o.cancellation_rate,0.00) AS cancellation_rate,
         COALESCE(o.dispute_rate,0.00) AS dispute_rate,
         s.avg_response_minutes,
         COALESCE(r.recent_impressions,0) AS recent_impressions
  FROM sellers s
  LEFT JOIN active_listing_counts a ON a.seller_id = s.seller_id
  LEFT JOIN order_metrics o ON o.seller_id = s.seller_id
  LEFT JOIN recent_impressions r ON r.seller_id = s.seller_id
  WHERE s.active = true
)
SELECT seller_id, seller_name, active_listings, completed_orders, cancellation_rate, dispute_rate,
       avg_response_minutes, recent_impressions,
       CASE WHEN recent_impressions >= 1 THEN 'eligible' END AS eligibility_reason
FROM eligibility
WHERE active_listings >= 3
  AND completed_orders >= 5
  AND cancellation_rate < 0.15
  AND dispute_rate < 0.08
  AND avg_response_minutes < 60
  AND recent_impressions >= 1
ORDER BY seller_id;
