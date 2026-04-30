SET search_path TO bip_sql_018;
SELECT user_id, 1 AS session_number, MIN(event_at) AS session_start, MAX(event_at) AS session_end, COUNT(*) AS event_count
FROM feed_events
GROUP BY user_id
ORDER BY user_id;
