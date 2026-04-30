SET search_path TO bip_sql_020;
WITH active_listing_counts AS (
  SELECT seller_id, COUNT(*) AS active_listings
  FROM listings
  WHERE status = 'active' AND blocked = false
  GROUP BY seller_id
), order_metrics AS (
  SELECT o.seller_id,
         COUNT(*) AS total_orders,
         COUNT(*) FILTER (WHERE o.status = 'completed') AS completed_orders,
         ROUND(COUNT(*) FILTER (WHERE o.status = 'cancelled')::numeric / NULLIF(COUNT(*),0), 2) AS cancellation_rate,
         ROUND(COUNT(DISTINCT d.dispute_id)::numeric / NULLIF(COUNT(*),0), 2) AS dispute_rate,
         ROUND(COUNT(DISTINCT r.refund_id)::numeric / NULLIF(COUNT(*),0), 2) AS refund_rate,
         COUNT(*) FILTER (WHERE o.status = 'cancelled' AND o.ordered_at >= DATE '2026-01-20') AS recent_cancellations
  FROM orders o
  LEFT JOIN disputes d ON d.order_id = o.order_id
  LEFT JOIN refunds r ON r.order_id = o.order_id
  GROUP BY o.seller_id
), response_metrics AS (
  SELECT seller_id, ROUND(AVG(response_minutes), 2) AS avg_response_minutes
  FROM response_events
  GROUP BY seller_id
), funnel_metrics AS (
  SELECT l.seller_id,
         COUNT(*) FILTER (WHERE li.event_type = 'impression' AND li.event_at >= DATE '2026-01-26') AS recent_impressions,
         COUNT(*) FILTER (WHERE li.event_type = 'contact' AND li.event_at >= DATE '2026-01-26') AS contacts,
         COUNT(*) FILTER (WHERE li.event_type = 'booking' AND li.event_at >= DATE '2026-01-26') AS bookings
  FROM listings l
  LEFT JOIN listing_impressions li ON li.listing_id = l.listing_id
  WHERE l.blocked = false
  GROUP BY l.seller_id
), seller_metrics AS (
  SELECT s.seller_id, s.seller_name,
         COALESCE(a.active_listings,0) AS active_listings,
         COALESCE(o.total_orders,0) AS total_orders,
         COALESCE(o.completed_orders,0) AS completed_orders,
         COALESCE(o.cancellation_rate,0.00) AS cancellation_rate,
         COALESCE(o.dispute_rate,0.00) AS dispute_rate,
         COALESCE(o.refund_rate,0.00) AS refund_rate,
         COALESCE(r.avg_response_minutes,0.00) AS avg_response_minutes,
         COALESCE(f.recent_impressions,0) AS recent_impressions,
         ROUND(COALESCE(f.contacts,0)::numeric / NULLIF(COALESCE(f.recent_impressions,0),0), 2) AS contact_rate,
         ROUND(COALESCE(f.bookings,0)::numeric / NULLIF(COALESCE(f.contacts,0),0), 2) AS booking_rate,
         COALESCE(o.recent_cancellations,0) AS recent_cancellations,
         EXISTS (SELECT 1 FROM fraud_cases fc WHERE fc.seller_id = s.seller_id AND fc.status = 'open') AS has_open_fraud_case
  FROM sellers s
  LEFT JOIN active_listing_counts a ON a.seller_id = s.seller_id
  LEFT JOIN order_metrics o ON o.seller_id = s.seller_id
  LEFT JOIN response_metrics r ON r.seller_id = s.seller_id
  LEFT JOIN funnel_metrics f ON f.seller_id = s.seller_id
)
SELECT seller_id, seller_name, active_listings, completed_orders, cancellation_rate, dispute_rate, refund_rate,
       avg_response_minutes, recent_impressions,
       COALESCE(contact_rate,0.00) AS contact_rate,
       COALESCE(booking_rate,0.00) AS booking_rate,
       CASE
         WHEN has_open_fraud_case OR dispute_rate >= 0.12 OR refund_rate >= 0.15 THEN 'suppress'
         WHEN (recent_impressions >= 5 AND COALESCE(booking_rate,0.00) < 0.20) OR recent_cancellations >= 2 OR (active_listings >= 2 AND completed_orders < 2 AND recent_impressions >= 3) THEN 'manual_review'
         WHEN total_orders >= 3 AND completed_orders::numeric / NULLIF(total_orders,0) >= 0.80 AND dispute_rate < 0.05 AND refund_rate < 0.05 AND avg_response_minutes <= 30 AND COALESCE(booking_rate,0.00) >= 0.50 THEN 'boost'
         WHEN active_listings = 0 OR recent_impressions = 0 OR cancellation_rate >= 0.25 OR avg_response_minutes > 60 OR COALESCE(booking_rate,0.00) < 0.30 THEN 'watch'
         ELSE 'allow'
       END AS treatment,
       CASE
         WHEN has_open_fraud_case THEN 'open_fraud_case'
         WHEN dispute_rate >= 0.12 THEN 'dispute_rate_high'
         WHEN refund_rate >= 0.15 THEN 'refund_rate_high'
         WHEN recent_impressions >= 5 AND COALESCE(booking_rate,0.00) < 0.20 THEN 'high_impressions_low_bookings'
         WHEN recent_cancellations >= 2 THEN 'recent_cancellation_spike'
         WHEN active_listings >= 2 AND completed_orders < 2 AND recent_impressions >= 3 THEN 'fast_growth_low_history'
         WHEN total_orders >= 3 AND completed_orders::numeric / NULLIF(total_orders,0) >= 0.80 AND dispute_rate < 0.05 AND refund_rate < 0.05 AND avg_response_minutes <= 30 AND COALESCE(booking_rate,0.00) >= 0.50 THEN 'high_completion_low_risk'
         WHEN active_listings = 0 THEN 'no_active_unblocked_listings'
         WHEN recent_impressions = 0 THEN 'no_recent_impressions'
         WHEN cancellation_rate >= 0.25 THEN 'cancellation_rate_watch'
         WHEN avg_response_minutes > 60 THEN 'slow_response_watch'
         WHEN COALESCE(booking_rate,0.00) < 0.30 THEN 'low_booking_rate_watch'
         ELSE 'meets_basic_trust_rules'
       END AS primary_reason
FROM seller_metrics
ORDER BY
  CASE
    WHEN has_open_fraud_case OR dispute_rate >= 0.12 OR refund_rate >= 0.15 THEN 5
    WHEN (recent_impressions >= 5 AND COALESCE(booking_rate,0.00) < 0.20) OR recent_cancellations >= 2 OR (active_listings >= 2 AND completed_orders < 2 AND recent_impressions >= 3) THEN 4
    WHEN total_orders >= 3 AND completed_orders::numeric / NULLIF(total_orders,0) >= 0.80 AND dispute_rate < 0.05 AND refund_rate < 0.05 AND avg_response_minutes <= 30 AND COALESCE(booking_rate,0.00) >= 0.50 THEN 1
    WHEN active_listings = 0 OR recent_impressions = 0 OR cancellation_rate >= 0.25 OR avg_response_minutes > 60 OR COALESCE(booking_rate,0.00) < 0.30 THEN 3
    ELSE 2
  END,
  seller_id;
