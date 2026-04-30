INSERT INTO users (id, handle) VALUES
  (1, 'ada'), (2, 'ben'), (3, 'cy'), (4, 'noor'), (5, 'diya'), (6, 'maya'), (7, 'lina');

INSERT INTO follows (follower_id, followee_id) VALUES (1, 2), (1, 3), (5, 2);
INSERT INTO mutes (muter_id, muted_id) VALUES (1, 3);
INSERT INTO blocks (blocker_id, blocked_id) VALUES (1, 4);

INSERT INTO posts (id, author_id, body, created_at) VALUES
  (101, 2, 'Ben creates post 101', '2026-01-01 10:00:00'),
  (201, 3, 'Cy creates post 201', '2026-01-01 10:01:00'),
  (301, 4, 'Noor creates post 301', '2026-01-01 10:02:00'),
  (401, 1, 'Ada post that receives activity', '2026-01-01 09:00:00');

INSERT INTO home_timeline_items (user_id, post_id, fanout_reason, inserted_at) VALUES
  (1, 101, 'followed_author_fanout', '2026-01-01 10:00:01'),
  (1, 201, 'muted_author_bad_fanout', '2026-01-01 10:01:01'),
  (1, 301, 'blocked_author_bad_fanout', '2026-01-01 10:02:01');

INSERT INTO notification_inbox (id, recipient_id, actor_id, notification_type, source_event_id, created_at, read_at) VALUES
  (1001, 1, 2, 'comment', 'evt-ben-comment', '2026-01-01 10:10:00', NULL),
  (1002, 1, 5, 'like', 'evt-diya-like', '2026-01-01 10:11:00', NULL),
  (1003, 1, 6, 'mention', 'evt-maya-mention', '2026-01-01 10:12:00', NULL),
  (1004, 1, 6, 'mention', 'evt-maya-mention', '2026-01-01 10:12:01', NULL),
  (1005, 1, 7, 'mention', 'evt-lina-old', '2025-12-31 08:00:00', '2026-01-01 08:30:00');

