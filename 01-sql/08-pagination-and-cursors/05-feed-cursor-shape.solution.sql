-- A cursor-shaped response returns both data and the fields needed to request
-- the next page. The cursor is not a page number; it is the last seen sort key.
CREATE VIEW feed_cursor_shape AS
SELECT
  id,
  body,
  created_at,
  created_at AS cursor_created_at,
  id AS cursor_id
FROM keyset_page_one;
