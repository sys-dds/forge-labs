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

-- Broken implementation: profiles, follows, blocks, listings, and saved listings
-- are only loose rows. Duplicate saves, duplicate profiles, self-follows, and
-- listings owned by missing sellers are all possible.

