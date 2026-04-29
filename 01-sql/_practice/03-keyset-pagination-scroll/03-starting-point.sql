CREATE OR REPLACE VIEW original_feed_order AS
SELECT id, author_handle, created_at
FROM feed_posts
ORDER BY created_at DESC, id DESC;

CREATE OR REPLACE VIEW keyset_page_one AS
SELECT id, author_handle, created_at
FROM feed_posts
ORDER BY created_at DESC, id DESC
LIMIT 2;
