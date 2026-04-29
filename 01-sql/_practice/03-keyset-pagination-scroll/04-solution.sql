DROP TABLE IF EXISTS scroll_cursor;
DROP TABLE IF EXISTS scroll_page_one;

CREATE TABLE scroll_page_one AS
  SELECT id, created_at
  FROM feed_posts
  ORDER BY created_at DESC, id DESC
  LIMIT 2;

CREATE TABLE scroll_cursor AS
SELECT created_at AS last_seen_created_at, id AS last_seen_id
FROM scroll_page_one
ORDER BY created_at ASC, id ASC
LIMIT 1;

INSERT INTO feed_posts (id, author_handle, body, created_at)
VALUES (108, 'ben', 'New post inserted after Ada saw page one.', '2026-04-29 10:07:00');

DROP VIEW IF EXISTS keyset_page_one;
CREATE OR REPLACE VIEW keyset_page_one AS
SELECT posts.id, posts.author_handle, posts.created_at
FROM scroll_page_one
JOIN feed_posts AS posts
  ON posts.id = scroll_page_one.id
ORDER BY posts.created_at DESC, posts.id DESC;

CREATE OR REPLACE VIEW keyset_page_two AS
SELECT id, author_handle, created_at
FROM feed_posts
WHERE (created_at, id) < (
  SELECT last_seen_created_at, last_seen_id
  FROM scroll_cursor
)
ORDER BY created_at DESC, id DESC
LIMIT 2;

CREATE OR REPLACE VIEW offset_page_two_after_insert AS
SELECT id, author_handle, created_at
FROM feed_posts
ORDER BY created_at DESC, id DESC
OFFSET 2
LIMIT 2;

CREATE OR REPLACE VIEW created_at_only_cursor_page_two AS
SELECT id, author_handle, created_at
FROM feed_posts
WHERE created_at < '2026-04-29 10:04:00'::timestamp
ORDER BY created_at DESC
LIMIT 2;
