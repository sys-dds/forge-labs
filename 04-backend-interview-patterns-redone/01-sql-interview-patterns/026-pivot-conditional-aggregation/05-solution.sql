SET search_path TO bip_sql_026;
SELECT s.seller_id, s.seller_name,
       COUNT(o.order_id) FILTER (WHERE o.status='completed') AS completed_orders,
       COUNT(o.order_id) FILTER (WHERE o.status='cancelled') AS cancelled_orders,
       COUNT(o.order_id) FILTER (WHERE o.status='disputed') AS disputed_orders,
       COUNT(o.order_id) FILTER (WHERE o.status='refunded') AS refunded_orders,
       COUNT(o.order_id) FILTER (WHERE o.status='open') AS open_orders,
       COALESCE(SUM(o.amount_pence) FILTER (WHERE o.status='completed'),0) AS total_gmv_pence,
       COALESCE(SUM(o.refund_amount_pence) FILTER (WHERE o.status='refunded'),0) AS refund_amount_pence
FROM sellers s
LEFT JOIN orders o ON o.seller_id=s.seller_id AND o.is_test=false AND o.ordered_at BETWEEN DATE '2026-03-01' AND DATE '2026-03-07'
GROUP BY s.seller_id,s.seller_name
ORDER BY s.seller_id;
