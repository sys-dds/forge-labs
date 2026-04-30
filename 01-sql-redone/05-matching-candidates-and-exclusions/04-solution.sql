CREATE VIEW mutual_matches AS
SELECT other.handle
FROM users ada
JOIN swipes ada_like ON ada_like.swiper_id = ada.id
JOIN swipes other_like ON other_like.swiper_id = ada_like.swiped_id
  AND other_like.swiped_id = ada.id
JOIN users other ON other.id = ada_like.swiped_id
WHERE ada.handle = 'ada'
  AND ada_like.decision = 'LIKE'
  AND other_like.decision = 'LIKE'
ORDER BY other.handle;

CREATE VIEW raw_candidates AS
SELECT other.handle
FROM users ada
JOIN users other ON other.id <> ada.id
WHERE ada.handle = 'ada'
  AND other.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM swipes s
    WHERE s.swiper_id = ada.id AND s.swiped_id = other.id
  )
  AND NOT EXISTS (
    SELECT 1 FROM blocks b
    WHERE b.blocker_id = ada.id AND b.blocked_id = other.id
  )
ORDER BY other.handle;

CREATE VIEW preference_fit_candidates AS
SELECT
  other.handle,
  COUNT(candidate_interest.interest) AS shared_interest_count
FROM users ada
JOIN preferences pref ON pref.user_id = ada.id
JOIN users other ON other.id <> ada.id
LEFT JOIN interests ada_interest ON ada_interest.user_id = ada.id
LEFT JOIN interests candidate_interest ON candidate_interest.user_id = other.id
  AND candidate_interest.interest = ada_interest.interest
WHERE ada.handle = 'ada'
  AND other.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM swipes s
    WHERE s.swiper_id = ada.id AND s.swiped_id = other.id
  )
  AND NOT EXISTS (
    SELECT 1 FROM blocks b
    WHERE b.blocker_id = ada.id AND b.blocked_id = other.id
  )
  AND other.city = pref.city
  AND other.age BETWEEN pref.min_age AND pref.max_age
GROUP BY other.handle
ORDER BY other.handle;

