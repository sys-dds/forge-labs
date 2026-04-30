INSERT INTO users (id, handle) VALUES
  (1, 'ada'), (2, 'ben'), (3, 'cy'), (4, 'noor'), (5, 'diya'), (6, 'maya'), (7, 'omar'), (8, 'lina');

INSERT INTO groups (id, name) VALUES (10, 'Backend Club'), (20, 'Design Club');
INSERT INTO group_memberships (group_id, user_id) VALUES (10, 1), (10, 5), (20, 8);
INSERT INTO follows (follower_id, followee_id) VALUES (1, 2), (1, 3);
INSERT INTO mutes (muter_id, muted_id) VALUES (1, 3);
INSERT INTO blocks (blocker_id, blocked_id) VALUES (1, 4);

INSERT INTO posts (id, author_id, group_id, visibility, is_hidden) VALUES
  (101, 2, NULL, 'public', false),
  (102, 2, NULL, 'followers', false),
  (103, 2, NULL, 'public', true),
  (201, 3, NULL, 'public', false),
  (301, 4, NULL, 'public', false),
  (401, 5, 10, 'group', false),
  (501, 7, NULL, 'public', false),
  (601, 8, 20, 'group', false);

INSERT INTO comments (id, post_id, user_id, body) VALUES
  (1001, 101, 6, 'Maya comment'),
  (1002, 101, 4, 'Noor comment');

INSERT INTO reactions (post_id, user_id, reaction_type) VALUES
  (101, 1, 'like'),
  (101, 3, 'like');

INSERT INTO reposts (post_id, user_id) VALUES
  (101, 5);

