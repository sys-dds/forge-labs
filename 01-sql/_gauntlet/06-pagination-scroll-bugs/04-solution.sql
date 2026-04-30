CREATE TABLE page_one_snapshot AS
SELECT id, created_at FROM feed_posts ORDER BY created_at DESC, id DESC LIMIT 2;
CREATE TABLE cursor_snapshot AS
SELECT created_at, id FROM page_one_snapshot ORDER BY created_at ASC, id ASC LIMIT 1;
INSERT INTO feed_posts VALUES (108,'inserted before page two','2026-04-29 10:07');
CREATE OR REPLACE VIEW gauntlet_page_one AS SELECT id, created_at FROM page_one_snapshot ORDER BY created_at DESC, id DESC;
CREATE OR REPLACE VIEW gauntlet_page_two AS
SELECT id, created_at FROM feed_posts
WHERE (created_at,id) < (SELECT created_at,id FROM cursor_snapshot)
ORDER BY created_at DESC, id DESC LIMIT 2;
CREATE OR REPLACE VIEW gauntlet_cursor AS SELECT created_at, id FROM cursor_snapshot;
CREATE OR REPLACE VIEW gauntlet_offset_page_two AS SELECT id FROM feed_posts ORDER BY created_at DESC, id DESC OFFSET 2 LIMIT 2;
