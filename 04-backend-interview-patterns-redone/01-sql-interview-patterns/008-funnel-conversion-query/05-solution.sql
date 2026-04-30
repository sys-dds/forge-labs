SET search_path TO bip_sql_008;
WITH views AS (
  SELECT user_id, MIN(event_at) AS viewed_at FROM funnel_events WHERE event_name = 'viewed' GROUP BY user_id
), contacts AS (
  SELECT v.user_id, v.viewed_at, MIN(e.event_at) AS contacted_at
  FROM views v LEFT JOIN funnel_events e ON e.user_id = v.user_id AND e.event_name = 'contacted' AND e.event_at > v.viewed_at
  GROUP BY v.user_id, v.viewed_at
), bookings AS (
  SELECT c.user_id, c.viewed_at, c.contacted_at, MIN(e.event_at) AS booked_at
  FROM contacts c LEFT JOIN funnel_events e ON e.user_id = c.user_id AND e.event_name = 'booked' AND e.event_at > c.contacted_at
  GROUP BY c.user_id, c.viewed_at, c.contacted_at
), completions AS (
  SELECT b.user_id, b.viewed_at, b.contacted_at, b.booked_at, MIN(e.event_at) AS completed_at
  FROM bookings b LEFT JOIN funnel_events e ON e.user_id = b.user_id AND e.event_name = 'completed' AND e.event_at > b.booked_at
  GROUP BY b.user_id, b.viewed_at, b.contacted_at, b.booked_at
), counts AS (
  SELECT COUNT(*) FILTER (WHERE viewed_at IS NOT NULL) AS viewed_count,
         COUNT(*) FILTER (WHERE contacted_at IS NOT NULL) AS contacted_count,
         COUNT(*) FILTER (WHERE booked_at IS NOT NULL) AS booked_count,
         COUNT(*) FILTER (WHERE completed_at IS NOT NULL) AS completed_count
  FROM completions
)
SELECT fs.step_name,
       CASE fs.step_name
         WHEN 'viewed' THEN counts.viewed_count
         WHEN 'contacted' THEN counts.contacted_count
         WHEN 'booked' THEN counts.booked_count
         WHEN 'completed' THEN counts.completed_count
       END AS users_reached
FROM funnel_steps fs
CROSS JOIN counts
ORDER BY fs.step_order;
