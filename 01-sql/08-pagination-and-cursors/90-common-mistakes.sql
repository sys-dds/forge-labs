-- Pagination and Cursors: intentionally wrong patterns for study.
-- These statements are illustrative and are not run by the proof harness.
-- Read them after the working solution so the failure mode is easy to name.

-- Mistake 1: ordering only by created_at
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 2: using offset for a changing feed
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 3: cursor without id tie-breaker
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 4: using page number as cursor
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 5: reversing DESC keyset comparison
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.
