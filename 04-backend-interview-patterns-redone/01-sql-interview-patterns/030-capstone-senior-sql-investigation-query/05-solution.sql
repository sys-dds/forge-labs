SET search_path TO bip_sql_030;
WITH active_listings AS (
  SELECT seller_id, COUNT(*) AS active_listing_count FROM listings WHERE status='active' AND blocked=false GROUP BY seller_id
), order_metrics AS (
  SELECT o.seller_id, COUNT(*) FILTER (WHERE o.status='completed') AS completed_orders,
         ROUND(COUNT(*) FILTER (WHERE o.status='cancelled')::numeric / NULLIF(COUNT(*),0),2) AS cancellation_rate,
         ROUND(COUNT(d.dispute_id)::numeric / NULLIF(COUNT(*),0),2) AS dispute_rate,
         ROUND(COUNT(r.refund_id)::numeric / NULLIF(COUNT(*),0),2) AS refund_rate
  FROM orders o LEFT JOIN disputes d ON d.order_id=o.order_id LEFT JOIN refunds r ON r.order_id=o.order_id GROUP BY o.seller_id
), engagement AS (
  SELECT l.seller_id,
         COUNT(e.event_id) FILTER (WHERE e.event_type='impression') AS recent_impressions,
         ROUND(COUNT(e.event_id) FILTER (WHERE e.event_type='contact')::numeric / NULLIF(COUNT(e.event_id) FILTER (WHERE e.event_type='impression'),0),2) AS contact_rate,
         ROUND(COUNT(e.event_id) FILTER (WHERE e.event_type='booking')::numeric / NULLIF(COUNT(e.event_id) FILTER (WHERE e.event_type='contact'),0),2) AS booking_rate
  FROM listings l LEFT JOIN listing_events e ON e.listing_id=l.listing_id AND e.event_at >= DATE '2026-05-01'
  WHERE l.blocked=false GROUP BY l.seller_id
), latest_moderation AS (
  SELECT DISTINCT ON (seller_id) seller_id, decision AS latest_moderation_decision FROM moderation_decisions ORDER BY seller_id, decided_at DESC, decision_id DESC
), ledger_mismatches AS (
  SELECT COALESCE(o.seller_id, -1) AS seller_id, COUNT(*) AS ledger_mismatch_count
  FROM orders o FULL OUTER JOIN ledger_entries le ON le.order_id=o.order_id
  WHERE o.order_id IS NULL OR le.ledger_id IS NULL OR o.amount_pence <> le.amount_pence
  GROUP BY COALESCE(o.seller_id, -1)
), transitions AS (
  SELECT o.seller_id, ose.order_id, ose.event_id, ose.status,
         LAG(ose.status) OVER (PARTITION BY ose.order_id ORDER BY ose.event_id) AS previous_status,
         COUNT(*) FILTER (WHERE ose.status='paid') OVER (PARTITION BY ose.order_id ORDER BY ose.event_id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS paid_before
  FROM order_status_events ose JOIN orders o ON o.order_id=ose.order_id
), invalid_transitions AS (
  SELECT seller_id, COUNT(*) AS invalid_order_transition_count
  FROM transitions
  WHERE (status='completed' AND (paid_before=0 OR previous_status='cancelled'))
  GROUP BY seller_id
), fraud AS (
  SELECT seller_id, COUNT(*) AS open_fraud_cases FROM fraud_cases WHERE status='open' GROUP BY seller_id
)
SELECT s.seller_id, s.seller_name, COALESCE(al.active_listing_count,0) AS active_listing_count,
       COALESCE(om.completed_orders,0) AS completed_orders, COALESCE(om.cancellation_rate,0.00) AS cancellation_rate,
       COALESCE(om.dispute_rate,0.00) AS dispute_rate, COALESCE(om.refund_rate,0.00) AS refund_rate,
       s.avg_response_minutes, COALESCE(e.recent_impressions,0) AS recent_impressions,
       COALESCE(e.contact_rate,0.00) AS contact_rate, COALESCE(e.booking_rate,0.00) AS booking_rate,
       COALESCE(lm.latest_moderation_decision,'no_decision') AS latest_moderation_decision,
       COALESCE(lg.ledger_mismatch_count,0) AS ledger_mismatch_count,
       COALESCE(it.invalid_order_transition_count,0) AS invalid_order_transition_count,
       CASE WHEN COALESCE(f.open_fraud_cases,0) > 0 THEN 'suppress'
            WHEN COALESCE(om.dispute_rate,0.00) >= 0.12 THEN 'suppress'
            WHEN COALESCE(om.refund_rate,0.00) >= 0.15 THEN 'suppress'
            WHEN COALESCE(lg.ledger_mismatch_count,0) > 0 THEN 'manual_review'
            WHEN COALESCE(it.invalid_order_transition_count,0) > 0 THEN 'manual_review'
            WHEN COALESCE(e.recent_impressions,0) >= 4 AND COALESCE(e.booking_rate,0.00) < 0.30 THEN 'watch'
            WHEN COALESCE(om.completed_orders,0) >= 3 AND COALESCE(om.dispute_rate,0.00) < 0.05 AND COALESCE(om.refund_rate,0.00) < 0.05 AND s.avg_response_minutes <= 30 AND COALESCE(e.booking_rate,0.00) >= 0.50 THEN 'boost'
            ELSE 'allow' END AS risk_treatment
FROM sellers s
LEFT JOIN active_listings al ON al.seller_id=s.seller_id
LEFT JOIN order_metrics om ON om.seller_id=s.seller_id
LEFT JOIN engagement e ON e.seller_id=s.seller_id
LEFT JOIN latest_moderation lm ON lm.seller_id=s.seller_id
LEFT JOIN ledger_mismatches lg ON lg.seller_id=s.seller_id
LEFT JOIN invalid_transitions it ON it.seller_id=s.seller_id
LEFT JOIN fraud f ON f.seller_id=s.seller_id
WHERE s.active=true
ORDER BY s.seller_id;
