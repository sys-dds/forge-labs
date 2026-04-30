CREATE VIEW ben_public_profile_card AS
SELECT
  u.handle,
  u.email,
  p.display_name,
  p.bio,
  COUNT(post_rows.id) AS visible_post_count,
  COUNT(follower_rows.follower_id) AS follower_count,
  COUNT(following_rows.followee_id) AS following_count
FROM users u
JOIN profiles p ON p.user_id = u.id
LEFT JOIN posts post_rows ON post_rows.author_id = u.id
LEFT JOIN follows follower_rows ON follower_rows.followee_id = u.id
LEFT JOIN follows following_rows ON following_rows.follower_id = u.id
WHERE u.handle = 'ben'
GROUP BY u.handle, u.email, p.display_name, p.bio;

CREATE VIEW ada_safe_profile_search AS
SELECT target.handle
FROM users ada
JOIN users target ON true
JOIN profiles profile_rows ON profile_rows.user_id = target.id
WHERE ada.handle = 'ada'
ORDER BY target.handle;

