INSERT INTO users (id, handle) VALUES
  (1, 'ada'),
  (2, 'ben'),
  (3, 'cy'),
  (4, 'diya'),
  (5, 'noor'),
  (6, 'theo');

INSERT INTO follows (follower_id, followee_id) VALUES
  (1, 2),
  (1, 3),
  (2, 1),
  (2, 4),
  (3, 4),
  (3, 5),
  (4, 1),
  (5, 1);

INSERT INTO user_blocks (blocker_id, blocked_id) VALUES
  (1, 5);

INSERT INTO user_mutes (muter_id, muted_id) VALUES
  (1, 3);
