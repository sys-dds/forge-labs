-- Aggregation and Counts: intentionally wrong patterns for study.
-- These statements are illustrative and are not run by the proof harness.
-- Read them after the working solution so the failure mode is easy to name.

-- Mistake 1: counting hidden posts
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 2: counting deleted comments
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 3: COUNT star after a join inflates metrics
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 4: using WHERE where HAVING is required
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 5: treating metrics as harmless even when ranking consumes them
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.
