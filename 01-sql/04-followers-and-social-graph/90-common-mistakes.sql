-- Followers and Social Graph: intentionally wrong patterns for study.
-- These statements are illustrative and are not run by the proof harness.
-- Read them after the working solution so the failure mode is easy to name.

-- Mistake 1: reversing follower_id and followee_id
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 2: suggestions include already-followed users
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 3: suggestions include Ada herself
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 4: suggestions include blocked Noor
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 5: treating mute like block or deleting the follow row
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.
