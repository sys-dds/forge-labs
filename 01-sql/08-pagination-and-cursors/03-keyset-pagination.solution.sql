-- Keyset pagination asks for rows after the last seen sort key.
CREATE VIEW keyset_page_one AS SELECT id, body, created_at FROM posts ORDER BY created_at DESC, id DESC LIMIT 2;
CREATE VIEW keyset_page_two AS SELECT id, body, created_at FROM posts WHERE (created_at, id) < ((SELECT created_at FROM keyset_page_one ORDER BY created_at ASC, id ASC LIMIT 1),(SELECT id FROM keyset_page_one ORDER BY created_at ASC, id ASC LIMIT 1)) ORDER BY created_at DESC, id DESC LIMIT 2;
