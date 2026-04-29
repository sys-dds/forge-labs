CREATE VIEW direct_replies_to_c1 AS
SELECT id, body FROM comments WHERE post_id = 100 AND parent_comment_id = 1 ORDER BY id;

