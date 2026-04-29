-- The feed candidate set is the safety boundary before ranking.
-- Ben posts survive. Cy is muted, Noor is blocked, Diya is not followed.
CREATE VIEW ada_feed_candidates AS
SELECT p.id AS post_id,
       p.body,
       author.id AS author_id,
       author.handle AS author_handle,
       profile.display_name,
       true AS viewer_follows_author
FROM posts p
JOIN follows f ON f.followee_id = p.author_id AND f.follower_id = 1
JOIN users author ON author.id = p.author_id
JOIN profiles profile ON profile.user_id = author.id
WHERE NOT EXISTS (SELECT 1 FROM mutes m WHERE m.muter_id = 1 AND m.muted_id = author.id)
  AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id = 1 AND b.blocked_id = author.id)
ORDER BY p.id;

