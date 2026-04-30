# Gauntlet Format

Each gauntlet pack is independent and runnable against an empty `public` schema.

Required files:

- `README.md`: quick purpose and commands.
- `gauntlet.manifest`: script-readable summary.
- `00-scenario.md`: the user-visible failure.
- `01-schema.sql`: minimal tables and constraints.
- `02-seed.sql`: named rows that expose the bug.
- `03-broken-query.sql`: realistic broken query that compiles.
- `04-solution.sql`: repaired query.
- `05-proof.tests.sql`: exact assertions that fail broken and pass solution.
- `06-debugging-notes.md`: how to inspect the failure.
- `07-break-fix-drills.md`: next mistakes to try intentionally.
- `08-interview-explanation.md`: concise explanation target.

The runner executes broken SQL plus proof first and expects failure. It then resets, executes solution SQL plus proof, and expects success.
