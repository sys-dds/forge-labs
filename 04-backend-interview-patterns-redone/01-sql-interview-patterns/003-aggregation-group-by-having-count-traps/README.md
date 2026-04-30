# Aggregation, GROUP BY, HAVING, and COUNT traps

Scenario: Creators publish posts with draft, deleted, and NULL engagement traps.

You will query `creators, posts`. The important trap rows are 102 has NULL and low engagement; 104 has draft/deleted rows; 101 has one zero engagement row. The solution must pass both the base and variant seeds, so do not hard-code answer IDs.
