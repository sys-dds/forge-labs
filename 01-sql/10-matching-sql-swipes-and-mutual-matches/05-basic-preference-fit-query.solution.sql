-- Preference fit comes after raw exclusions. Maya fits Ada's age, city, and
-- shared-interest requirements. Omar remains a raw candidate but fails fit.
CREATE VIEW ada_preference_fit_candidates AS
WITH ada AS (
  SELECT p.*, pref.min_age, pref.max_age, pref.city AS preferred_city
  FROM matching_profiles p JOIN matching_preferences pref ON pref.user_id = p.user_id
  WHERE p.user_id = 1
)
SELECT raw.user_id,
       raw.handle,
       cardinality(ARRAY(SELECT unnest(candidate.interests) INTERSECT SELECT unnest(ada.interests))) AS shared_interest_count
FROM ada_raw_matching_candidates raw
JOIN matching_profiles candidate ON candidate.user_id = raw.user_id
CROSS JOIN ada
WHERE candidate.age BETWEEN ada.min_age AND ada.max_age
  AND (ada.preferred_city IS NULL OR candidate.city = ada.preferred_city)
  AND cardinality(ARRAY(SELECT unnest(candidate.interests) INTERSECT SELECT unnest(ada.interests))) >= 2
ORDER BY raw.handle;

