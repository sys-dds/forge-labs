INSERT INTO users (id, handle) VALUES
  (1, 'ada'),
  (2, 'ben'),
  (3, 'cy'),
  (4, 'noor'),
  (5, 'diya'),
  (6, 'maya');

INSERT INTO follows (follower_id, followed_id) VALUES
  (1, 2),
  (1, 3),
  (1, 4);

INSERT INTO mutes (muter_id, muted_id) VALUES (1, 3);
INSERT INTO blocks (blocker_id, blocked_id) VALUES (1, 4);

INSERT INTO posts (id, author_id, body, is_hidden, created_at) VALUES
  (101, 2, 'Ben visible older', false, '2026-01-01 10:01:00'),
  (102, 2, 'Ben visible newer with no comments', false, '2026-01-01 10:02:00'),
  (201, 3, 'Cy muted post', false, '2026-01-01 10:03:00'),
  (301, 4, 'Noor blocked post', false, '2026-01-01 10:04:00'),
  (401, 5, 'Diya unfollowed post', false, '2026-01-01 10:05:00'),
  (103, 2, 'Ben hidden post', true, '2026-01-01 10:06:00');

INSERT INTO post_likes (post_id, user_id) VALUES
  (101, 1),
  (101, 6),
  (102, 1),
  (201, 6),
  (301, 6),
  (103, 6);

INSERT INTO comments (id, post_id, user_id, body) VALUES
  (1001, 101, 1, 'Ada asks for details'),
  (1002, 101, 6, 'Maya likes this'),
  (1003, 101, 2, 'Ben replies'),
  (2001, 201, 6, 'Muted author still has activity'),
  (3001, 301, 6, 'Blocked author still has activity'),
  (4001, 401, 6, 'Unfollowed activity'),
  (1004, 103, 6, 'Hidden activity');

