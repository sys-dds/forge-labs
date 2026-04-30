# Senior SQL Correctness Patterns

Use clinics 021-030 to practice proving correctness when one happy-path query is not enough. Recursive CTEs must guard cycles, keyset pagination must use the same sort keys as the cursor, and state-transition checks must compare neighboring events instead of only final rows.
