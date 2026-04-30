SET search_path TO bip_pim_004;

-- Detail query: latest active likes per user/post.
SELECT DISTINCT ON (post_id, user_id) post_id, user_id, active
FROM post_reactions
ORDER BY post_id, user_id, created_at DESC, reaction_event_id DESC;

-- Comment query: visible top-level comments only.
SELECT comment_id, post_id, author_user_id, body
FROM comments
WHERE parent_comment_id IS NULL AND deleted_at IS NULL
ORDER BY comment_id;

-- Reply query: visible replies whose parent comment is still visible.
SELECT r.comment_id, r.parent_comment_id, r.body
FROM comments r
JOIN comments p ON p.comment_id=r.parent_comment_id
WHERE r.deleted_at IS NULL AND p.deleted_at IS NULL
ORDER BY r.comment_id;
