INSERT INTO users (id, handle, is_active, age, city) VALUES
  (1, 'ada', true, 30, 'London'),
  (2, 'ben', true, 31, 'London'),
  (3, 'cy', true, 32, 'London'),
  (4, 'diya', true, 29, 'London'),
  (5, 'noor', false, 28, 'London'),
  (6, 'maya', true, 29, 'London'),
  (7, 'omar', true, 42, 'Paris');

INSERT INTO preferences (user_id, min_age, max_age, city) VALUES
  (1, 25, 35, 'London');

INSERT INTO interests (user_id, interest) VALUES
  (1, 'sql'), (1, 'backend'), (1, 'music'),
  (2, 'sql'),
  (3, 'backend'),
  (4, 'music'),
  (5, 'sql'),
  (6, 'sql'), (6, 'backend'), (6, 'cycling'),
  (7, 'sql'), (7, 'travel');

INSERT INTO swipes (swiper_id, swiped_id, decision) VALUES
  (1, 2, 'LIKE'),
  (2, 1, 'LIKE'),
  (1, 3, 'PASS'),
  (3, 1, 'LIKE');

INSERT INTO blocks (blocker_id, blocked_id) VALUES
  (1, 4);

