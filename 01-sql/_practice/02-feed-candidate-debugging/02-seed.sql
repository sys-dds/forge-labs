INSERT INTO users (id, handle) VALUES
  (1, 'ada'),
  (2, 'ben'),
  (3, 'cy'),
  (4, 'noor'),
  (5, 'diya'),
  (6, 'maya'),
  (7, 'omar');

INSERT INTO follows (follower_id, followee_id) VALUES
  (1, 2),
  (1, 3),
  (1, 4);

INSERT INTO user_mutes (muter_id, muted_id) VALUES
  (1, 3);

INSERT INTO user_blocks (blocker_id, blocked_id) VALUES
  (1, 4);

INSERT INTO posts (id, author_id, body) VALUES
  (101, 2, 'Ben explains why feed ranking starts after eligibility.'),
  (102, 2, 'Ben posts a quiet update with no comments yet.'),
  (201, 3, 'Cy post should be hidden because Ada muted Cy.'),
  (301, 4, 'Noor post should be hidden because Ada blocked Noor.'),
  (401, 5, 'Diya post should be absent because Ada does not follow Diya.');

INSERT INTO post_likes (post_id, user_id) VALUES
  (101, 1),
  (101, 6),
  (102, 1);

INSERT INTO post_comments (id, post_id, author_id, body) VALUES
  (1001, 101, 1, 'Ada asks for the SQL shape.'),
  (1002, 101, 6, 'Maya notices the join trap.'),
  (1003, 101, 7, 'Omar confirms ranking comes later.');
