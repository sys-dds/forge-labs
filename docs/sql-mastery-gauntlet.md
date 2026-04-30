# SQL Mastery Gauntlet

Gauntlet mode is broken-query repair. Each pack runs the broken query first and expects the proof to fail, then resets and runs the solution.

Use it after practice mode:

```bash
./scripts/forge-list-gauntlet.sh
./scripts/forge-test-gauntlet.sh 01-sql/_gauntlet/01-feed-candidate-query-clinic
./scripts/forge-test-all-gauntlets.sh
```

A useful gauntlet answer names the exact wrong row, the bug that allowed it, and the predicate or query shape that fixes it.
