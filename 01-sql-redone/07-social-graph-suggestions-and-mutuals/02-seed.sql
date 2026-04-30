INSERT INTO users (id, handle) VALUES
  (1, 'ada'),
  (2, 'ben'),
  (3, 'cy'),
  (4, 'diya'),
  (5, 'noor'),
  (6, 'omar'),
  (7, 'theo'),
  (8, 'maya');

INSERT INTO follows (follower_id, followee_id) VALUES
  (1, 2),
  (1, 3),
  (2, 1),
  (2, 4),
  (3, 4),
  (3, 5),
  (8, 4),
  (1, 8),
  (5, 1),
  (6, 1);

INSERT INTO blocks (blocker_id, blocked_id) VALUES
  (1, 5);

