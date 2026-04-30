CREATE VIEW page_one_before_insert AS
SELECT id, created_at
FROM posts
WHERE id <> 108
ORDER BY created_at DESC, id DESC
LIMIT 2;

INSERT INTO posts (id, body, created_at) VALUES
  (108, 'post 108 inserted after page one', '2026-01-01 10:06:00');

CREATE VIEW keyset_page_two_after_106 AS
SELECT id, created_at
FROM posts
WHERE (created_at, id) < ('2026-01-01 10:04:00'::timestamp, 106)
ORDER BY created_at DESC, id DESC
LIMIT 2;

CREATE VIEW duplicate_timestamp_order AS
SELECT id, created_at
FROM posts
WHERE created_at = '2026-01-01 10:03:00'
ORDER BY created_at DESC, id DESC;

CREATE VIEW created_at_only_after_105 AS
SELECT id, created_at
FROM posts
WHERE (created_at, id) < ('2026-01-01 10:03:00'::timestamp, 105)
ORDER BY created_at DESC, id DESC
LIMIT 2;

