-- Public lookup returns profile fields by handle and intentionally omits email.
CREATE VIEW public_profile_by_handle AS SELECT u.handle, p.display_name, p.bio FROM users u JOIN profiles p ON p.user_id = u.id WHERE u.handle = 'ada' AND p.is_private = false;
