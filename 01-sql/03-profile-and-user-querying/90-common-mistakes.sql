-- Profile and User Querying: intentionally wrong patterns for study.
-- These statements are illustrative and are not run by the proof harness.
-- Read them after the working solution so the failure mode is easy to name.

-- Mistake 1: SELECT star leaking email
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 2: profile counts inflated by joining posts and follows together
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 3: private profile returned by search
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 4: returning database table shape as API shape
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 5: missing handle converted into a fake error row
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.
