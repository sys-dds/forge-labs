CREATE OR REPLACE VIEW gauntlet_profile_card AS
SELECT u.handle, u.email, p.display_name, count(posts.id)::integer AS post_count, count(followers.follower_id)::integer AS follower_count, count(following.followee_id)::integer AS following_count
FROM users u
JOIN profiles p ON p.user_id=u.id
LEFT JOIN posts ON posts.author_id=u.id
LEFT JOIN follows followers ON followers.followee_id=u.id
LEFT JOIN follows following ON following.follower_id=u.id
WHERE u.handle='ada'
GROUP BY u.handle, u.email, p.display_name;

CREATE OR REPLACE VIEW gauntlet_search_results AS
SELECT u.handle FROM users u JOIN profiles p ON p.user_id=u.id ORDER BY u.handle;
