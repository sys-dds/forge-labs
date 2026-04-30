CREATE OR REPLACE VIEW raw_candidates AS
SELECT c.handle FROM users ada JOIN users c ON c.id<>ada.id
WHERE ada.handle='ada' AND c.active
  AND NOT EXISTS (SELECT 1 FROM swipes s WHERE s.swiper_id=ada.id AND s.swiped_id=c.id)
  AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id=ada.id AND b.blocked_id=c.id)
ORDER BY c.handle;
CREATE OR REPLACE VIEW preference_fit_candidates AS
SELECT c.handle, count(i2.interest)::integer AS shared_interest_count
FROM users ada JOIN prefs p ON p.user_id=ada.id JOIN users c ON c.handle IN (SELECT handle FROM raw_candidates)
LEFT JOIN interests i1 ON i1.user_id=ada.id LEFT JOIN interests i2 ON i2.user_id=c.id AND i2.interest=i1.interest
WHERE ada.handle='ada' AND c.age BETWEEN p.min_age AND p.max_age
GROUP BY c.handle HAVING count(i2.interest)>0 ORDER BY c.handle;
