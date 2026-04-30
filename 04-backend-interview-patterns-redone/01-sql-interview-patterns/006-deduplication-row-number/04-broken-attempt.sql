SET search_path TO bip_sql_006;
SELECT listing_id, MAX(status) AS latest_status, MAX(event_at) AS event_at, MAX(event_id) AS event_id
FROM listing_status_events
GROUP BY listing_id
HAVING MAX(status) NOT IN ('removed', 'sold')
ORDER BY listing_id;
