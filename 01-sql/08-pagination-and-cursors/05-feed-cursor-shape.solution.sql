-- A cursor response usually returns the next cursor fields beside the rows.
CREATE VIEW feed_cursor_shape AS SELECT id, body, created_at, id AS cursor_id, created_at AS cursor_created_at FROM keyset_page_one;
