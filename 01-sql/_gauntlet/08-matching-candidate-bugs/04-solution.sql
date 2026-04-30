CREATE OR REPLACE VIEW gauntlet_mutual_matches AS
SELECT other.handle FROM users ada
JOIN swipes a ON a.swiper_id=ada.id AND a.action='LIKE'
JOIN swipes b ON b.swiper_id=a.swiped_id AND b.swiped_id=ada.id AND b.action='LIKE'
JOIN users other ON other.id=a.swiped_id WHERE ada.handle='ada';
CREATE OR REPLACE VIEW gauntlet_raw_candidates AS
SELECT candidate.handle FROM users ada JOIN users candidate ON candidate.id<>ada.id
WHERE ada.handle='ada' AND candidate.active
  AND NOT EXISTS (SELECT 1 FROM swipes s WHERE s.swiper_id=ada.id AND s.swiped_id=candidate.id)
  AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id=ada.id AND b.blocked_id=candidate.id)
ORDER BY candidate.handle;
CREATE OR REPLACE VIEW gauntlet_fit_candidates AS
SELECT c.handle, count(i2.interest)::integer AS shared_interest_count
FROM users ada JOIN prefs p ON p.user_id=ada.id JOIN users c ON c.id<>ada.id
LEFT JOIN interests i1 ON i1.user_id=ada.id LEFT JOIN interests i2 ON i2.user_id=c.id AND i2.interest=i1.interest
WHERE ada.handle='ada' AND c.handle IN (SELECT handle FROM gauntlet_raw_candidates) AND c.age BETWEEN p.min_age AND p.max_age
GROUP BY c.handle HAVING count(i2.interest)>0 ORDER BY c.handle;
