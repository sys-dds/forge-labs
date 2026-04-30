SET search_path TO bip_pim_001;

-- Screen query: public profile fields for a handle when viewer 2 is not blocked.
SELECT p.handle, f.field_name, f.field_value
FROM profiles p
JOIN users u ON u.user_id=p.user_id
JOIN profile_field_visibility f ON f.profile_id=p.profile_id
LEFT JOIN user_blocks b ON b.owner_user_id=p.user_id AND b.blocked_user_id=2
WHERE p.handle='ada_dev' AND u.active=true AND b.owner_user_id IS NULL AND f.visibility='public'
ORDER BY f.field_name;

-- Owner query: owner 1 can see public and private fields on their own profile.
SELECT p.handle, f.field_name, f.visibility
FROM profiles p
JOIN profile_field_visibility f ON f.profile_id=p.profile_id
WHERE p.handle='ada_dev' AND p.user_id=1
ORDER BY f.field_name;

-- Debug query: handles and active state for profile URL lookup.
SELECT p.handle, u.display_name, u.active
FROM profiles p JOIN users u ON u.user_id=p.user_id
ORDER BY p.handle;
