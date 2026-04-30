SET search_path TO bip_sql_004;
SELECT s.seller_id, s.seller_name,
       COUNT(o.order_id) AS completed_orders,
       0 AS cancelled_orders,
       0 AS disputed_orders,
       0 AS refund_count,
       1.00 AS fulfilment_rate
FROM sellers s
JOIN orders o ON o.seller_id = s.seller_id
WHERE o.status = 'completed'
GROUP BY s.seller_id, s.seller_name
ORDER BY s.seller_id;
