CREATE VIEW public_profile_by_handle AS
SELECT u.handle, p.display_name, p.bio
FROM users u JOIN profiles p ON p.user_id = u.id
WHERE p.searchable;

