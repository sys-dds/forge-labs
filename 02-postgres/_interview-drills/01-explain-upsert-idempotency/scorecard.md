# Scorecard

Senior signal: Mention immutable payload is not overwritten.

Red flag: Says upsert just saves time.

Trade-off to mention: database-owned correctness is durable, but hidden rules need local docs and proof tests.

Harder follow-up: explain how the proof would fail if the policy, constraint, trigger, or function were removed.
