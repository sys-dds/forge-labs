INSERT INTO users (id, handle, is_internal) VALUES
  (1, 'ada', false),
  (2, 'ben', false),
  (3, 'cy', false),
  (4, 'diya', false),
  (5, 'noor', true),
  (6, 'maya', false),
  (7, 'omar', false);

INSERT INTO events (id, user_id, event_name, event_at) VALUES
  (101, 1, 'signup', '2026-01-01 09:00:00'),
  (102, 1, 'feed_view', '2026-01-01 09:05:00'),
  (103, 1, 'post_created', '2026-01-01 09:30:00'),
  (201, 2, 'signup', '2026-01-01 10:00:00'),
  (202, 2, 'feed_view', '2026-01-01 10:20:00'),
  (301, 3, 'signup', '2026-01-01 11:00:00'),
  (302, 3, 'signup', '2026-01-01 11:01:00'),
  (401, 4, 'feed_view', '2026-01-01 12:00:00'),
  (501, 5, 'signup', '2026-01-01 13:00:00'),
  (502, 5, 'feed_view', '2026-01-01 13:05:00'),
  (503, 5, 'post_created', '2026-01-01 13:10:00'),
  (601, 6, 'signup', '2026-01-01 14:00:00'),
  (602, 6, 'post_created', '2026-01-02 09:00:00'),
  (701, 7, 'signup', '2026-01-02 08:00:00');

