SET search_path TO bip_sql_010;
WITH active_listings AS (
  SELECT seller_id, COUNT(*) AS active_listings
  FROM listings
  WHERE status = 'active' AND blocked = false
  GROUP BY seller_id
), order_metrics AS (
  SELECT seller_id,
         SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
         ROUND(SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(*),0), 2) AS cancellation_rate,
         ROUND(SUM(CASE WHEN disputed THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(*),0), 2) AS dispute_rate
  FROM orders
  GROUP BY seller_id
), event_metrics AS (
  SELECT l.seller_id,
         SUM(CASE WHEN e.event_name = 'impression' AND e.event_at >= DATE '2026-01-01' THEN 1 ELSE 0 END) AS recent_listing_impressions,
         SUM(CASE WHEN e.event_name = 'contact' AND e.event_at >= DATE '2026-01-01' THEN 1 ELSE 0 END) AS contacts,
         SUM(CASE WHEN e.event_name = 'booking' AND e.event_at >= DATE '2026-01-01' THEN 1 ELSE 0 END) AS bookings
  FROM listings l
  LEFT JOIN listing_events e ON e.listing_id = l.listing_id
  WHERE l.blocked = false
  GROUP BY l.seller_id
), metrics AS (
  SELECT s.seller_id, s.seller_name,
         COALESCE(al.active_listings,0) AS active_listings,
         COALESCE(om.completed_orders,0) AS completed_orders,
         COALESCE(om.cancellation_rate,0.00) AS cancellation_rate,
         COALESCE(om.dispute_rate,0.00) AS dispute_rate,
         s.avg_response_minutes AS average_response_time,
         COALESCE(em.recent_listing_impressions,0) AS recent_listing_impressions,
         ROUND(COALESCE(em.contacts,0)::numeric / NULLIF(COALESCE(em.recent_listing_impressions,0),0), 2) AS contact_rate,
         ROUND(COALESCE(em.bookings,0)::numeric / NULLIF(COALESCE(em.contacts,0),0), 2) AS booking_rate
  FROM sellers s
  LEFT JOIN active_listings al ON al.seller_id = s.seller_id
  LEFT JOIN order_metrics om ON om.seller_id = s.seller_id
  LEFT JOIN event_metrics em ON em.seller_id = s.seller_id
)
SELECT seller_id, seller_name, active_listings, completed_orders, cancellation_rate, dispute_rate,
       average_response_time, recent_listing_impressions,
       COALESCE(contact_rate,0.00) AS contact_rate,
       COALESCE(booking_rate,0.00) AS booking_rate,
       CASE
         WHEN dispute_rate >= 0.30 OR cancellation_rate >= 0.40 THEN 'suppress'
         WHEN recent_listing_impressions >= 3 AND COALESCE(booking_rate,0.00) < 0.50 THEN 'watch'
         WHEN completed_orders >= 2 AND cancellation_rate <= 0.25 AND dispute_rate <= 0.10 AND average_response_time <= 15 AND COALESCE(booking_rate,0.00) >= 0.80 THEN 'boost'
         ELSE 'allow'
       END AS seller_treatment
FROM metrics
WHERE active_listings > 0
ORDER BY CASE
         WHEN dispute_rate >= 0.30 OR cancellation_rate >= 0.40 THEN 4
         WHEN recent_listing_impressions >= 3 AND COALESCE(booking_rate,0.00) < 0.50 THEN 3
         WHEN completed_orders >= 2 AND cancellation_rate <= 0.25 AND dispute_rate <= 0.10 AND average_response_time <= 15 AND COALESCE(booking_rate,0.00) >= 0.80 THEN 1
         ELSE 2
       END,
       seller_id;
