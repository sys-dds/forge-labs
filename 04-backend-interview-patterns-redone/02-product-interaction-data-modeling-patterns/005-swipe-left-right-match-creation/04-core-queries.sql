SET search_path TO bip_pim_005;

-- Event query: latest swipe direction per pair direction.
SELECT DISTINCT ON (swiper_user_id, swiped_user_id) swiper_user_id, swiped_user_id, direction
FROM swipe_events
ORDER BY swiper_user_id, swiped_user_id, created_at DESC, swipe_event_id DESC;

-- Match query: active canonical matches only.
SELECT user_id_low, user_id_high
FROM matches
WHERE unmatched_at IS NULL
ORDER BY user_id_low, user_id_high;

-- Candidate query: discoverable users before applying swipe/match suppression.
SELECT u.user_id, u.display_name, p.city
FROM users u JOIN user_profiles p ON p.user_id=u.user_id
WHERE u.active=true AND p.discoverable=true
ORDER BY u.user_id;
