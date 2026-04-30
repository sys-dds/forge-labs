INSERT INTO users (id, handle, age, active) VALUES
  (1, 'ada', 30, true),
  (2, 'ben', 31, true),
  (3, 'cy', 29, true),
  (4, 'diya', 30, true),
  (5, 'noor', 28, false),
  (6, 'maya', 32, true),
  (7, 'omar', 45, true);

INSERT INTO profile_details (user_id, city) VALUES
  (1, 'London'),
  (2, 'London'),
  (3, 'London'),
  (4, 'London'),
  (5, 'London'),
  (6, 'London'),
  (7, 'London');

INSERT INTO profile_preferences (user_id, min_age, max_age, preferred_city) VALUES
  (1, 28, 35, 'London'),
  (2, 28, 35, 'London'),
  (3, 28, 35, 'London'),
  (4, 28, 35, 'London'),
  (5, 28, 35, 'London'),
  (6, 28, 35, 'London'),
  (7, 28, 50, 'London');

INSERT INTO swipes (swiper_id, swiped_id, action) VALUES
  (1, 2, 'LIKE'),
  (2, 1, 'LIKE'),
  (1, 3, 'PASS'),
  (3, 1, 'LIKE');

INSERT INTO user_blocks (blocker_id, blocked_id) VALUES
  (1, 4);

INSERT INTO user_interests (user_id, interest) VALUES
  (1, 'sql'),
  (1, 'systems'),
  (1, 'running'),
  (2, 'sql'),
  (2, 'music'),
  (3, 'systems'),
  (4, 'sql'),
  (5, 'running'),
  (6, 'sql'),
  (6, 'systems'),
  (6, 'gardening'),
  (7, 'sql');
