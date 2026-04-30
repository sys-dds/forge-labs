SET search_path TO bip_sql_006;
WITH ranked AS (
  SELECT listing_id, status, event_at, event_id,
         ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY event_at DESC, event_id DESC) AS rn
  FROM listing_status_events
)
SELECT listing_id, status AS latest_status, event_at, event_id
FROM ranked
WHERE rn = 1
  AND status NOT IN ('removed', 'sold')
ORDER BY listing_id;
