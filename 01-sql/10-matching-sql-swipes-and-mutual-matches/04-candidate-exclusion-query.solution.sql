-- Raw candidates apply safety and history exclusions only: self, already swiped,
-- blocked, and inactive. Omar survives this layer even though preference fit
-- will reject him later; that separation makes debugging easier.
CREATE VIEW ada_raw_matching_candidates AS
SELECT candidate.user_id, u.handle
FROM matching_profiles candidate
JOIN users u ON u.id = candidate.user_id
WHERE candidate.user_id <> 1
  AND candidate.active
  AND NOT EXISTS (SELECT 1 FROM swipes s WHERE s.swiper_id = 1 AND s.target_id = candidate.user_id)
  AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id = 1 AND b.blocked_id = candidate.user_id)
ORDER BY u.handle;

