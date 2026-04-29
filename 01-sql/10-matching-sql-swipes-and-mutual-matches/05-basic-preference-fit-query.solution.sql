-- Preference fit is still SQL candidate filtering: age range, city, and shared interests.
-- The overlap operator is used for a fast yes/no filter. The unnest subquery
-- counts shared interests so a later ranking path has a raw signal to score.
CREATE VIEW ada_preference_fit AS
SELECT
  candidate.handle,
  (
    SELECT count(*)
    FROM unnest(profile.interests) AS candidate_interest
    WHERE candidate_interest = ANY (viewer.interests)
  ) AS shared_interest_count
FROM users AS candidate
JOIN matching_profiles AS profile
  ON profile.user_id = candidate.id
JOIN matching_profiles AS viewer
  ON viewer.user_id = 1
JOIN matching_preferences AS pref
  ON pref.user_id = 1
WHERE candidate.id IN (SELECT id FROM ada_match_candidates)
  AND profile.age BETWEEN pref.min_age AND pref.max_age
  AND (pref.city IS NULL OR profile.city = pref.city)
  AND profile.interests && viewer.interests
ORDER BY shared_interest_count DESC, candidate.handle;
