INSERT INTO users (id, handle) VALUES
  (1, 'ada'), (2, 'ben'), (3, 'cy'), (4, 'diya'), (5, 'noor'),
  (6, 'maya'), (7, 'omar'), (8, 'lina'), (9, 'theo');

INSERT INTO groups (id, name) VALUES (10, 'Backend Club');
INSERT INTO follows (follower_id, followee_id) VALUES (1, 2), (1, 3), (1, 4);
INSERT INTO mutes (muter_id, muted_id) VALUES (1, 3);
INSERT INTO blocks (blocker_id, blocked_id) VALUES (1, 5);
INSERT INTO group_memberships (group_id, user_id) VALUES (10, 1), (10, 6);

INSERT INTO posts (id, author_id, group_id, created_at) VALUES
  (101, 2, NULL, '2026-01-01 10:01:00'),
  (201, 3, NULL, '2026-01-01 10:02:00'),
  (301, 6, 10, '2026-01-01 10:03:00'),
  (601, 8, NULL, '2026-01-01 10:04:00'),
  (602, 8, NULL, '2026-01-01 10:05:00'),
  (701, 5, NULL, '2026-01-01 10:06:00'),
  (801, 7, NULL, '2026-01-01 10:07:00'),
  (901, 9, NULL, '2026-01-01 10:08:00');

INSERT INTO post_likes (post_id, user_id) VALUES (601, 4), (701, 4);
INSERT INTO reposts (post_id, user_id) VALUES (602, 4);

