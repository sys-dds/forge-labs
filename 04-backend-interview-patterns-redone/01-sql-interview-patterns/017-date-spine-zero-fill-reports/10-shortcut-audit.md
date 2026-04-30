# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `bookings`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Replace the date spine with direct GROUP BY and zero days disappear..
- What the learner should inspect manually: 2026-01-02 has only a cancelled booking; 2026-01-03 has no rows; 2026-01-08 is outside the range; 2026-01-01 has multiple completed bookings.
