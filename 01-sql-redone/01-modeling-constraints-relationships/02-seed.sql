INSERT INTO users (id, handle, role) VALUES
  (1, 'ada', 'buyer'),
  (2, 'ben', 'seller'),
  (3, 'cy', 'seller'),
  (4, 'diya', 'buyer'),
  (5, 'noor', 'buyer');

INSERT INTO profiles (id, user_id, profile_type, display_name) VALUES
  (1001, 1, 'buyer', 'Ada Buyer'),
  (1002, 2, 'seller', 'Ben Services'),
  (1003, 3, 'seller', 'Cy Repairs');

INSERT INTO listings (id, seller_id, title) VALUES
  (101, 2, 'Ben sink repair'),
  (102, 2, 'Ben shelf install'),
  (201, 3, 'Cy garden cleanup');

INSERT INTO follows (follower_id, followed_id) VALUES
  (1, 2);

INSERT INTO blocks (blocker_id, blocked_id) VALUES
  (1, 3);

INSERT INTO saved_listings (user_id, listing_id) VALUES
  (1, 101),
  (4, 101);

