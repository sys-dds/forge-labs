# Scorecard

Senior signal: USING differs from WITH CHECK.

Red flag: Only tests SELECT happy path.

Trade-off to mention: database-owned correctness is durable, but hidden rules need local docs and proof tests.

Harder follow-up: explain how the proof would fail if the policy, constraint, trigger, or function were removed.
