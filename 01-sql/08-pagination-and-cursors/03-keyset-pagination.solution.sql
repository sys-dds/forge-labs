-- Keyset page one chooses a boundary row. Page two asks for rows older than the
-- last seen pair, not rows after a moving numeric offset.
CREATE VIEW keyset_page_one AS
SELECT id, created_at FROM feed_posts ORDER BY created_at DESC, id DESC LIMIT 3;
CREATE VIEW keyset_page_two AS
SELECT id, created_at
FROM feed_posts
WHERE (created_at, id) < ('2026-01-01 10:05:00+00'::timestamptz, 104)
ORDER BY created_at DESC, id DESC
LIMIT 3;

