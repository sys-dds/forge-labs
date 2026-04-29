CREATE VIEW feed_cursor_shape AS
SELECT id AS last_seen_id,
       created_at AS last_seen_created_at,
       encode(convert_to(created_at::text || ':' || id::text, 'UTF8'), 'base64') AS example_cursor_token
FROM keyset_page_one
ORDER BY created_at ASC, id ASC
LIMIT 1;

