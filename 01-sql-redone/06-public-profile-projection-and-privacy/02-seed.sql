INSERT INTO users (id, handle, email) VALUES
  (1, 'ada', 'ada@example.test'),
  (2, 'ben', 'ben-private@example.test'),
  (3, 'cy', 'cy@example.test'),
  (4, 'diya', 'diya@example.test'),
  (5, 'noor', 'noor@example.test'),
  (6, 'maya', 'maya@example.test');

INSERT INTO profiles (user_id, display_name, bio, is_searchable) VALUES
  (1, 'Ada Viewer', 'Ada reads profiles', true),
  (2, 'Ben Builder', 'Repairs and careful notes', true),
  (3, 'Cy Private', 'Cy opted out', false),
  (4, 'Diya New', 'Diya has not posted yet', true),
  (5, 'Noor Public', 'Noor is public but blocked', true),
  (6, 'Maya Member', 'Maya follows Ben', false);

INSERT INTO posts (id, author_id, body, is_hidden) VALUES
  (201, 2, 'Ben visible one', false),
  (202, 2, 'Ben visible two', false),
  (203, 2, 'Ben hidden draft', true),
  (301, 3, 'Cy visible but private profile', false),
  (501, 5, 'Noor visible but blocked', false);

INSERT INTO post_likes (post_id, user_id) VALUES
  (201, 6);

INSERT INTO comments (id, post_id, user_id, body) VALUES
  (9001, 202, 6, 'Maya asks Ben for availability');

INSERT INTO follows (follower_id, followee_id) VALUES
  (1, 2),
  (6, 2),
  (2, 1);

INSERT INTO blocks (blocker_id, blocked_id) VALUES
  (1, 5);
