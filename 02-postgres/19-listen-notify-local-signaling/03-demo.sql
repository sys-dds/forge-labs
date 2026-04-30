SELECT channel, payload
FROM notification_outbox
WHERE channel = 'domain_events'
ORDER BY event_id;
