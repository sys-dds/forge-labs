SET search_path TO bip_sql_008;
SELECT event_name AS step_name, COUNT(DISTINCT user_id) AS users_reached
FROM funnel_events
WHERE event_name IN ('viewed','contacted','booked','completed')
GROUP BY event_name
ORDER BY users_reached DESC, step_name;
