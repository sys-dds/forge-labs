CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer LANGUAGE plpgsql AS $$
BEGIN RAISE EXCEPTION '%', message; END;
$$;

CREATE TEMP TABLE expected_timeline (post_id integer, author_handle text);
INSERT INTO expected_timeline VALUES (101, 'ben');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_timeline EXCEPT SELECT post_id, author_handle FROM ada_home_timeline)
  UNION ALL
  (SELECT post_id, author_handle FROM ada_home_timeline EXCEPT SELECT * FROM expected_timeline)
) THEN 1 ELSE fail_test('expected Ada home timeline {Ben post 101}; broken read model leaked muted Cy 201 or blocked Noor 301') END AS home_timeline_exact;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_home_timeline WHERE post_id IN (201, 301))
  THEN 1 ELSE fail_test('expected Cy 201 and Noor 301 excluded from Ada timeline by read-time mute/block filters') END AS unsafe_timeline_rows_excluded;

CREATE TEMP TABLE expected_inbox (actor_handle text, notification_type text, source_event_id text);
INSERT INTO expected_inbox VALUES
  ('ben', 'comment', 'evt-ben-comment'),
  ('diya', 'like', 'evt-diya-like'),
  ('maya', 'mention', 'evt-maya-mention'),
  ('lina', 'mention', 'evt-lina-old');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_inbox EXCEPT SELECT actor_handle, notification_type, source_event_id FROM ada_notification_inbox)
  UNION ALL
  (SELECT actor_handle, notification_type, source_event_id FROM ada_notification_inbox EXCEPT SELECT * FROM expected_inbox)
) THEN 1 ELSE fail_test('expected Ada inbox {Ben comment,Diya like,Maya mention,Lina read mention}; broken inbox duplicated Maya or lost a notification row') END AS notification_inbox_exact;

SELECT CASE WHEN (SELECT COUNT(*) FROM ada_notification_inbox WHERE source_event_id = 'evt-maya-mention') = 1
  THEN 1 ELSE fail_test('expected one Maya mention for source_event_id evt-maya-mention; broken inbox kept duplicate source event rows') END AS maya_mention_deduped;

SELECT CASE WHEN (SELECT unread_count FROM ada_unread_notification_count) = 3
  THEN 1 ELSE fail_test('expected unread count 3 before reading Maya mention; broken count included Lina read row or duplicate Maya row') END AS unread_count_before_read;

UPDATE notification_inbox
SET read_at = '2026-01-01 10:20:00'
WHERE recipient_id = 1 AND source_event_id = 'evt-maya-mention';

SELECT CASE WHEN (SELECT unread_count FROM ada_unread_notification_count) = 2
  THEN 1 ELSE fail_test('expected unread count 2 after Ada reads Maya mention; broken count ignored read_at or duplicate source events') END AS unread_count_after_maya_read;

