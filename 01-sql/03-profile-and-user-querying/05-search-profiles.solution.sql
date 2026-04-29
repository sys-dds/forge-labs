CREATE VIEW search_profiles AS
SELECT handle, display_name
FROM public_profile_by_handle
WHERE handle LIKE '%a%' OR lower(display_name) LIKE '%a%'
ORDER BY handle;

