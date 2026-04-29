-- Keyset pagination asks for rows after the last row on the previous page.
-- The ordering is descending by created_at and then id. The id tie-breaker is
-- required because two posts can share the same timestamp.
CREATE VIEW keyset_page_one AS
SELECT
  id,
  body,
  created_at
FROM posts
ORDER BY created_at DESC, id DESC
LIMIT 2;

-- The second page uses the last row from page one as the cursor. In a real API
-- the client would send these two values back as the next cursor.
CREATE VIEW keyset_page_two AS
WITH last_seen AS (
  SELECT created_at, id
  FROM keyset_page_one
  ORDER BY created_at ASC, id ASC
  LIMIT 1
)
SELECT
  p.id,
  p.body,
  p.created_at
FROM posts AS p
CROSS JOIN last_seen
WHERE (p.created_at, p.id) < (last_seen.created_at, last_seen.id)
ORDER BY p.created_at DESC, p.id DESC
LIMIT 2;
