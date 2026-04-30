CREATE TABLE page_one_snapshot AS
SELECT id, created_at FROM feed_posts ORDER BY created_at DESC LIMIT 2;
INSERT INTO feed_posts VALUES (108,'inserted before page two','2026-04-29 10:07');
CREATE OR REPLACE VIEW gauntlet_page_one AS SELECT id, created_at FROM page_one_snapshot ORDER BY created_at DESC;
CREATE OR REPLACE VIEW gauntlet_page_two AS SELECT id, created_at FROM feed_posts ORDER BY created_at DESC OFFSET 2 LIMIT 2;
CREATE OR REPLACE VIEW gauntlet_cursor AS SELECT max(created_at) AS created_at, null::integer AS id FROM page_one_snapshot;
