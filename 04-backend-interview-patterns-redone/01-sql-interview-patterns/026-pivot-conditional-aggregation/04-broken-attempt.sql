SET search_path TO bip_sql_026;
SELECT s.seller_id,s.seller_name,COUNT(o.order_id) AS completed_orders,0 AS cancelled_orders,0 AS disputed_orders,0 AS refunded_orders,0 AS open_orders,COALESCE(SUM(o.amount_pence),0) AS total_gmv_pence,0 AS refund_amount_pence
FROM sellers s LEFT JOIN orders o ON o.seller_id=s.seller_id
WHERE o.status='completed' AND o.is_test=false AND o.ordered_at BETWEEN DATE '2026-03-01' AND DATE '2026-03-07'
GROUP BY s.seller_id,s.seller_name ORDER BY s.seller_id;
