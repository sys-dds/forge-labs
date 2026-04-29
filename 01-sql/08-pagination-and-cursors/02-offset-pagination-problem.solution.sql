-- Simulate a new post arriving above Ada's second offset request.
-- OFFSET 3 now starts after the new row, so row 104 is repeated across the two
-- pages a user saw. That is the feed-scroll bug keyset pagination avoids.
CREATE TABLE feed_posts_after_insert AS
SELECT * FROM feed_posts;
INSERT INTO feed_posts_after_insert VALUES
  (107,'noor','inserted before second page','2026-01-01 10:07:00+00');
CREATE VIEW offset_page_two_after_insert AS
SELECT id, created_at FROM feed_posts_after_insert ORDER BY created_at DESC, id DESC LIMIT 3 OFFSET 3;

