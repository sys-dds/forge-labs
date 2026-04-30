# Workshop Format

A Forge Labs chapter is a course chapter, not a puzzle dump.

Each real chapter has a README, a concept explainer, numbered solution SQL, chapter-specific common mistakes, chapter-specific extension tasks, and a proof test. The solution files are meant to be read before you experiment.

## Modes

- **Test mode**: `./scripts/forge-test.sh <chapter>` resets the database, loads solutions, and runs proof assertions.
- **Study mode**: `./scripts/forge-load.sh <chapter>` resets the database, loads solutions, and leaves the data available for Adminer, DbGate, or psql inspection.
- **Inspect mode**: `./scripts/forge-inspect.sh <chapter>` prints reading order, solution execution order, proof file, dataset story file, and Adminer/DbGate connection notes without changing the database.
- **Practice mode**: `./scripts/forge-load-practice.sh <pack>` loads an independent scenario pack, while `./scripts/forge-test-practice.sh <pack>` runs its solution and proof tests.
- **Gauntlet mode**: `./scripts/forge-test-gauntlet.sh <pack>` proves the broken query fails, then proves the solution passes.
- **Take-home mode**: `./scripts/forge-test-takehome.sh <pack>` runs a compact assessment solution and proof.
- **Interview/self-assessment mode**: Markdown prompts and scorecards train explanation and next-study decisions.
- **Quality gate**: `./scripts/check-workshop-quality.sh` catches missing chapter files, too-few solution files, and repeated generic teaching text.

## Practice Pack Format

A practice pack is smaller than a chapter and more operational. It has a `challenge.manifest`, scenario, schema, seed data, starter SQL, solution SQL, proof tests, exact expected results, break/fix drills, and an interview explanation. Use chapter mode to learn the idea, then practice mode to prove you can operate the idea on named data.

## Proof Style

Proof tests use SQL assertions. They should fail when an important predicate, constraint, or ordering rule is removed. A good proof checks both the row that should appear and the row that must not appear.
