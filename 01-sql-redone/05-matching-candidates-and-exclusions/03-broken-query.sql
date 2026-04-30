CREATE VIEW mutual_matches AS
SELECT other.handle
FROM users ada
JOIN swipes ada_swipe ON ada_swipe.swiper_id = ada.id
JOIN swipes other_swipe ON other_swipe.swiper_id = ada_swipe.swiped_id
  AND other_swipe.swiped_id = ada.id
JOIN users other ON other.id = ada_swipe.swiped_id
WHERE ada.handle = 'ada'
  AND ada_swipe.decision IN ('LIKE', 'PASS')
  AND other_swipe.decision IN ('LIKE', 'PASS')
ORDER BY other.handle;

CREATE VIEW raw_candidates AS
SELECT other.handle
FROM users ada
JOIN users other ON other.id <> ada.id
WHERE ada.handle = 'ada'
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
  AND other.city = pref.city
  AND other.age BETWEEN pref.min_age AND pref.max_age
GROUP BY other.handle
ORDER BY other.handle;

