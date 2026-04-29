-- Preference fit is still SQL candidate filtering: age range, city, and
-- shared interests. PostgreSQL has an array-overlap operator for the
-- yes/no filter, then an unnest-based subquery gives the count that a later
-- ranking path could use as a raw signal.
CREATE VIEW ada_preference_fit AS
SELECT
  u.handle,
  (
    SELECT count(*)
    FROM unnest(p.interests) AS candidate_interest
    WHERE candidate_interest = ANY (viewer.interests)
  ) AS shared_interest_count
FROM users u
JOIN matching_profiles p ON p.user_id = u.id
JOIN matching_profiles viewer ON viewer.user_id = 1
JOIN matching_preferences pref ON pref.user_id = 1
WHERE u.id IN (SELECT id FROM ada_match_candidates)
  AND p.age BETWEEN pref.min_age AND pref.max_age
  AND (pref.city IS NULL OR p.city = pref.city)
  AND p.interests && viewer.interests
ORDER BY shared_interest_count DESC, u.handle;
