-- Search returns public profile fields only. This keeps private account fields out of read models.
CREATE VIEW search_profiles AS SELECT u.handle, p.display_name FROM users u JOIN profiles p ON p.user_id = u.id WHERE p.is_private = false AND (u.handle ILIKE '%a%' OR p.display_name ILIKE '%a%') ORDER BY u.handle;
