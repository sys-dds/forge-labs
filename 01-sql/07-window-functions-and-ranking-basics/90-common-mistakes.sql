-- Window Functions and Ranking Inputs: intentionally wrong patterns for study.
-- These statements are illustrative and are not run by the proof harness.
-- Read them after the working solution so the failure mode is easy to name.

-- Mistake 1: ROW_NUMBER without deterministic tie-breaker
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 2: confusing RANK and DENSE_RANK
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 3: running total without PARTITION BY
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 4: treating rank label as the final algorithm
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 5: filtering a window alias in the same query layer
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.
