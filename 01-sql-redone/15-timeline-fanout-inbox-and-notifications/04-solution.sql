CREATE VIEW ada_home_timeline AS
SELECT post_rows.id AS post_id, author.handle AS author_handle, timeline_rows.fanout_reason
FROM users viewer
JOIN home_timeline_items timeline_rows ON timeline_rows.user_id = viewer.id
JOIN posts post_rows ON post_rows.id = timeline_rows.post_id
JOIN users author ON author.id = post_rows.author_id
WHERE viewer.handle = 'ada'
  AND NOT EXISTS (SELECT 1 FROM mutes m WHERE m.muter_id = viewer.id AND m.muted_id = post_rows.author_id)
  AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id = viewer.id AND b.blocked_id = post_rows.author_id)
ORDER BY timeline_rows.inserted_at;

CREATE VIEW ada_notification_inbox AS
SELECT DISTINCT ON (notification_rows.source_event_id)
  notification_rows.id AS notification_id,
  actor.handle AS actor_handle,
  notification_rows.notification_type,
  notification_rows.source_event_id,
  notification_rows.read_at
FROM users viewer
JOIN notification_inbox notification_rows ON notification_rows.recipient_id = viewer.id
JOIN users actor ON actor.id = notification_rows.actor_id
WHERE viewer.handle = 'ada'
ORDER BY notification_rows.source_event_id, notification_rows.created_at, notification_rows.id;

CREATE VIEW ada_unread_notification_count AS
SELECT COUNT(*) AS unread_count
FROM ada_notification_inbox
WHERE read_at IS NULL;

