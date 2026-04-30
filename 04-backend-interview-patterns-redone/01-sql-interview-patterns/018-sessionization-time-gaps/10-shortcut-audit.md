# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `feed_events`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Change the gap rule to >= 30 minutes and the exact 30-minute event splits incorrectly..
- What the learner should inspect manually: user 101 has exactly a 30-minute gap that stays in session; user 101 has a 31-minute gap that starts a new session; duplicate timestamps require event_id tie-break; multiple users appear.
