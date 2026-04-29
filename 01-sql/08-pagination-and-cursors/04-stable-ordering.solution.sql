-- The two 10:05 rows prove created_at alone is ambiguous. The id tie-breaker
-- makes the ordering stable and gives the cursor a unique boundary.
CREATE VIEW stable_timestamp_ties AS
SELECT id, created_at
FROM feed_posts
WHERE created_at = '2026-01-01 10:05:00+00'::timestamptz
ORDER BY created_at DESC, id DESC;

