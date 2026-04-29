-- created_at alone can tie. Adding id makes ordering deterministic.
CREATE VIEW stable_ordering AS SELECT id, body FROM posts ORDER BY created_at DESC, id DESC;
