-- Joins and Feed Candidates: intentionally wrong patterns for study.
-- These statements are illustrative and are not run by the proof harness.
-- Read them after the working solution so the failure mode is easy to name.

-- Mistake 1: inner join removes post 102 because it has zero comments
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 2: likes and comments multiply rows for post 101
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 3: missing block or mute filters
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 4: ranking before candidate filtering
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 5: joining profile data into the count query before isolating metrics
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.
