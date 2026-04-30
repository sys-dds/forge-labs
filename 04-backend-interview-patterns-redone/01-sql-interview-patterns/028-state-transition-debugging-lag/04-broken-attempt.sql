SET search_path TO bip_sql_028;
SELECT order_id, MAX(event_id) AS event_id, NULL AS previous_status, MAX(status) AS current_status, 'final_status_only' AS violation_reason
FROM order_status_events
GROUP BY order_id
HAVING MAX(status) IN ('shipped','refunded')
ORDER BY order_id;
