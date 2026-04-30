SET search_path TO bip_sql_028;
WITH ordered AS (
  SELECT order_id, event_id, status AS current_status, event_at,
         LAG(status) OVER (PARTITION BY order_id ORDER BY event_id) AS previous_status,
         LAG(event_at) OVER (PARTITION BY order_id ORDER BY event_id) AS previous_event_at,
         COUNT(*) FILTER (WHERE status='paid') OVER (PARTITION BY order_id ORDER BY event_id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS paid_before,
         COUNT(*) FILTER (WHERE status='completed') OVER (PARTITION BY order_id ORDER BY event_id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS completed_before
  FROM order_status_events
)
SELECT order_id, event_id, previous_status, current_status,
       CASE
         WHEN previous_event_at IS NOT NULL AND event_at < previous_event_at THEN 'timestamp_went_backwards'
         WHEN previous_status='cancelled' AND current_status IN ('shipped','completed') THEN 'terminal_status_after_cancelled'
         WHEN current_status='completed' AND paid_before=0 THEN 'completed_before_paid'
         WHEN current_status='refunded' AND completed_before=0 THEN 'refunded_before_completed'
         WHEN previous_status IN ('completed','refunded','cancelled') AND current_status=previous_status THEN 'duplicate_terminal_status'
       END AS violation_reason
FROM ordered
WHERE (previous_event_at IS NOT NULL AND event_at < previous_event_at)
   OR (current_status='completed' AND paid_before=0)
   OR (current_status='refunded' AND completed_before=0)
   OR (previous_status='cancelled' AND current_status IN ('shipped','completed'))
   OR (previous_status IN ('completed','refunded','cancelled') AND current_status=previous_status)
ORDER BY order_id, event_id;
