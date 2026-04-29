-- A profile card is a backend response shape, not a table dump.
CREATE VIEW profile_card AS SELECT u.handle, p.display_name, p.bio FROM users u JOIN profiles p ON p.user_id = u.id WHERE u.handle = 'ada';
