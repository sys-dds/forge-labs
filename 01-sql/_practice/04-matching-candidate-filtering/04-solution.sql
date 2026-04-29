CREATE OR REPLACE VIEW ada_mutual_matches AS
SELECT other.handle AS matched_handle
FROM users AS ada
JOIN swipes AS ada_like
  ON ada_like.swiper_id = ada.id
 AND ada_like.action = 'LIKE'
JOIN swipes AS other_like
  ON other_like.swiper_id = ada_like.swiped_id
 AND other_like.swiped_id = ada.id
 AND other_like.action = 'LIKE'
JOIN users AS other
  ON other.id = ada_like.swiped_id
WHERE ada.handle = 'ada'
ORDER BY other.handle;

CREATE OR REPLACE VIEW ada_raw_candidates AS
SELECT candidate.handle AS candidate_handle
FROM users AS ada
JOIN users AS candidate
  ON candidate.id <> ada.id
WHERE ada.handle = 'ada'
  AND candidate.active
  AND NOT EXISTS (
    SELECT 1
    FROM swipes AS already_swiped
    WHERE already_swiped.swiper_id = ada.id
      AND already_swiped.swiped_id = candidate.id
  )
  AND NOT EXISTS (
    SELECT 1
    FROM user_blocks AS blocked
    WHERE blocked.blocker_id = ada.id
      AND blocked.blocked_id = candidate.id
  )
ORDER BY candidate.handle;

CREATE OR REPLACE VIEW ada_preference_fit_candidates AS
SELECT
  candidate.handle AS candidate_handle,
  count(candidate_interests.interest)::integer AS shared_interest_count
FROM users AS ada
JOIN profile_preferences AS ada_pref
  ON ada_pref.user_id = ada.id
JOIN users AS candidate
  ON candidate.id <> ada.id
JOIN profile_details AS candidate_profile
  ON candidate_profile.user_id = candidate.id
LEFT JOIN user_interests AS ada_interests
  ON ada_interests.user_id = ada.id
LEFT JOIN user_interests AS candidate_interests
  ON candidate_interests.user_id = candidate.id
 AND candidate_interests.interest = ada_interests.interest
WHERE ada.handle = 'ada'
  AND candidate.handle IN (SELECT candidate_handle FROM ada_raw_candidates)
  AND candidate.age BETWEEN ada_pref.min_age AND ada_pref.max_age
  AND candidate_profile.city = ada_pref.preferred_city
GROUP BY candidate.handle
HAVING count(candidate_interests.interest) > 0
ORDER BY candidate.handle;
