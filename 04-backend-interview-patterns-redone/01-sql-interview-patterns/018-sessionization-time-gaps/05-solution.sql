SET search_path TO bip_sql_018;
WITH ordered AS (
  SELECT user_id, event_id, event_at,
         LAG(event_at) OVER (PARTITION BY user_id ORDER BY event_at, event_id) AS previous_event_at
  FROM feed_events
), marked AS (
  SELECT user_id, event_id, event_at,
         CASE WHEN previous_event_at IS NULL OR event_at > previous_event_at + INTERVAL '30 minutes' THEN 1 ELSE 0 END AS new_session_flag
  FROM ordered
), sessioned AS (
  SELECT user_id, event_id, event_at,
         SUM(new_session_flag) OVER (PARTITION BY user_id ORDER BY event_at, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS session_number
  FROM marked
)
SELECT user_id, session_number, MIN(event_at) AS session_start, MAX(event_at) AS session_end, COUNT(*) AS event_count
FROM sessioned
GROUP BY user_id, session_number
ORDER BY user_id, session_number;
