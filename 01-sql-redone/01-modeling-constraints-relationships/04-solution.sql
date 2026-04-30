ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_unique UNIQUE (user_id),
  ADD CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE listings
  ADD CONSTRAINT listings_seller_id_fk FOREIGN KEY (seller_id) REFERENCES users(id);

ALTER TABLE follows
  ADD CONSTRAINT follows_pk PRIMARY KEY (follower_id, followed_id),
  ADD CONSTRAINT follows_follower_fk FOREIGN KEY (follower_id) REFERENCES users(id),
  ADD CONSTRAINT follows_followed_fk FOREIGN KEY (followed_id) REFERENCES users(id),
  ADD CONSTRAINT follows_no_self CHECK (follower_id <> followed_id);

ALTER TABLE blocks
  ADD CONSTRAINT blocks_pk PRIMARY KEY (blocker_id, blocked_id),
  ADD CONSTRAINT blocks_blocker_fk FOREIGN KEY (blocker_id) REFERENCES users(id),
  ADD CONSTRAINT blocks_blocked_fk FOREIGN KEY (blocked_id) REFERENCES users(id),
  ADD CONSTRAINT blocks_no_self CHECK (blocker_id <> blocked_id);

ALTER TABLE saved_listings
  ADD CONSTRAINT saved_listings_pk PRIMARY KEY (user_id, listing_id),
  ADD CONSTRAINT saved_listings_user_fk FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT saved_listings_listing_fk FOREIGN KEY (listing_id) REFERENCES listings(id);

CREATE VIEW marketplace_relationship_snapshot AS
SELECT
  u.handle,
  p.profile_type,
  l.id AS listing_id,
  s.listing_id AS saved_listing_id
FROM users u
LEFT JOIN profiles p ON p.user_id = u.id
LEFT JOIN listings l ON l.seller_id = u.id
LEFT JOIN saved_listings s ON s.user_id = u.id;

