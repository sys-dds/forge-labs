-- Tables and Relationships: intentionally wrong patterns for study.
-- These statements are illustrative and are not run by the proof harness.
-- Read them after the working solution so the failure mode is easy to name.

-- Mistake 1: profile table with separate id but no unique user_id
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 2: posts without author foreign key
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 3: follows_preview with surrogate id but no unique pair
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 4: optional settings forced onto users as nullable columns
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.

-- Mistake 5: using SELECT star as the schema mental model
-- The authored dataset contains a row that would expose this bug during proof or manual inspection.
