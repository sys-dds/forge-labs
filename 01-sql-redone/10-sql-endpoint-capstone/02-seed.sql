INSERT INTO users (id, handle, email) VALUES
  (1, 'ada', 'ada@example.test'),
  (2, 'ben', 'ben@example.test'),
  (3, 'cy', 'cy@example.test'),
  (4, 'diya', 'diya@example.test'),
  (5, 'noor', 'noor@example.test'),
  (6, 'maya', 'maya@example.test'),
  (7, 'omar', 'omar@example.test'),
  (8, 'theo', 'theo@example.test'),
  (9, 'lina', 'lina@example.test');

INSERT INTO profiles (user_id, display_name, is_searchable) VALUES
  (1, 'Ada Viewer', true),
  (2, 'Ben Followed', true),
  (3, 'Cy Blocked', true),
  (4, 'Diya Creator', true),
  (5, 'Noor Private', false),
  (6, 'Maya Creator', true),
  (7, 'Omar Quiet', true),
  (8, 'Theo Disconnected', true),
  (9, 'Lina Creator', true);

INSERT INTO follows (follower_id, followee_id) VALUES
  (1, 2),
  (2, 4),
  (2, 6),
  (2, 9),
  (3, 1),
  (5, 2),
  (2, 7),
  (6, 4),
  (7, 4),
  (4, 6),
  (6, 9);

INSERT INTO blocks (blocker_id, blocked_id) VALUES
  (1, 3);

INSERT INTO posts (id, author_id, body, is_hidden, created_at) VALUES
  (201, 2, 'Ben visible followed', false, '2026-01-01 10:10:00'),
  (301, 3, 'Cy visible blocked', false, '2026-01-01 10:11:00'),
  (401, 4, 'Diya visible one', false, '2026-01-01 10:01:00'),
  (402, 4, 'Diya visible two', false, '2026-01-01 10:08:00'),
  (501, 5, 'Noor visible private', false, '2026-01-01 10:12:00'),
  (601, 6, 'Maya visible one', false, '2026-01-01 10:05:00'),
  (701, 7, 'Omar hidden only', true, '2026-01-01 10:20:00'),
  (901, 9, 'Lina visible one', false, '2026-01-01 10:05:00');

