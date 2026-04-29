-- Direct replies are only immediate children of one parent comment.
CREATE VIEW direct_replies AS SELECT id, body FROM comments WHERE parent_comment_id=1 ORDER BY id;
