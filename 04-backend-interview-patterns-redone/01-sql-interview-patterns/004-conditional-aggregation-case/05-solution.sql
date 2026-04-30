SET search_path TO bip_sql_004;
SELECT s.seller_id, s.seller_name,
       SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
       SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
       SUM(CASE WHEN o.status = 'disputed' THEN 1 ELSE 0 END) AS disputed_orders,
       SUM(CASE WHEN o.refunded THEN 1 ELSE 0 END) AS refund_count,
       ROUND(SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(o.order_id), 0), 2) AS fulfilment_rate
FROM sellers s
LEFT JOIN orders o ON o.seller_id = s.seller_id
GROUP BY s.seller_id, s.seller_name
ORDER BY s.seller_id;
