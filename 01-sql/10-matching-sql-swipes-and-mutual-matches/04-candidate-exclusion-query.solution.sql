-- Candidate filtering happens before ranking. The database removes users who
-- should never reach a scoring algorithm: Ada herself, users Ada already
-- swiped on, blocked users, and inactive profiles.
CREATE VIEW ada_match_candidates AS
SELECT
  candidate.id,
  candidate.handle
FROM users AS candidate
JOIN matching_profiles AS profile
  ON profile.user_id = candidate.id
WHERE candidate.id <> 1
  AND profile.active = true
  AND NOT EXISTS (
    SELECT 1
    FROM swipes AS prior_decision
    WHERE prior_decision.swiper_id = 1
      AND prior_decision.target_id = candidate.id
  )
  AND NOT EXISTS (
    SELECT 1
    FROM blocks AS blocked
    WHERE blocked.blocker_id = 1
      AND blocked.blocked_id = candidate.id
  )
ORDER BY candidate.id;
