SET search_path TO bip_pim_002;

-- Screen query: active follow edges after block suppression.
SELECT f.follower_user_id, f.followee_user_id
FROM follow_edges f
LEFT JOIN block_edges b ON b.blocker_user_id=f.followee_user_id AND b.blocked_user_id=f.follower_user_id
WHERE f.status='active' AND b.blocker_user_id IS NULL
ORDER BY f.follower_user_id, f.followee_user_id;

-- Count query: follower count per author from source edges.
SELECT followee_user_id AS author_user_id, COUNT(*) AS follower_count
FROM follow_edges f
LEFT JOIN block_edges b ON b.blocker_user_id=f.followee_user_id AND b.blocked_user_id=f.follower_user_id
WHERE f.status='active' AND b.blocker_user_id IS NULL
GROUP BY followee_user_id
ORDER BY author_user_id;

-- Visibility query: can viewer 4 see Ben's author row?
SELECT p.post_id, p.author_user_id
FROM posts p
LEFT JOIN block_edges b ON b.blocker_user_id=p.author_user_id AND b.blocked_user_id=4
WHERE p.post_id=201 AND b.blocker_user_id IS NULL;
