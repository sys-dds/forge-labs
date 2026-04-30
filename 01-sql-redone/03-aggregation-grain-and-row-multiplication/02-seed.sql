INSERT INTO authors (id, handle) VALUES
  (1, 'ada'),
  (2, 'ben'),
  (3, 'cy');

INSERT INTO posts (id, author_id, is_hidden, created_at) VALUES
  ('A1', 1, false, '2026-01-01 10:00:00'),
  ('A2', 1, false, '2026-01-01 10:01:00'),
  ('A3', 1, true, '2026-01-01 10:02:00'),
  ('B1', 2, false, '2026-01-01 10:03:00');

INSERT INTO post_likes (post_id, user_id) VALUES
  ('A1', 10), ('A1', 11),
  ('A2', 12),
  ('A3', 10), ('A3', 11), ('A3', 12), ('A3', 13), ('A3', 14),
  ('B1', 10), ('B1', 11), ('B1', 12);

INSERT INTO comments (id, post_id, user_id, body) VALUES
  (101, 'A1', 10, 'A1 c1'),
  (102, 'A1', 11, 'A1 c2'),
  (103, 'A1', 12, 'A1 c3'),
  (301, 'A3', 10, 'A3 c1'),
  (302, 'A3', 11, 'A3 c2'),
  (303, 'A3', 12, 'A3 c3'),
  (304, 'A3', 13, 'A3 c4'),
  (305, 'A3', 14, 'A3 c5'),
  (201, 'B1', 10, 'B1 c1');

