SET search_path TO bip_sql_030;
SELECT s.seller_id,s.seller_name,COUNT(l.listing_id) AS active_listing_count,0 AS completed_orders,0.00 AS cancellation_rate,0.00 AS dispute_rate,0.00 AS refund_rate,s.avg_response_minutes,COUNT(e.event_id) AS recent_impressions,0.00 AS contact_rate,0.00 AS booking_rate,'unknown' AS latest_moderation_decision,0 AS ledger_mismatch_count,0 AS invalid_order_transition_count,'boost' AS risk_treatment
FROM sellers s LEFT JOIN listings l ON l.seller_id=s.seller_id LEFT JOIN listing_events e ON e.listing_id=l.listing_id AND e.event_type='impression'
GROUP BY s.seller_id,s.seller_name,s.avg_response_minutes ORDER BY recent_impressions DESC;
