# Workshop Format

A Forge Labs chapter is a course chapter, not a puzzle dump.

Each real chapter has a README, a concept explainer, numbered solution SQL, chapter-specific common mistakes, chapter-specific extension tasks, and a proof test. The solution files are meant to be read before you experiment.

## Modes

- **Test mode**: `./scripts/forge-test.sh <chapter>` resets the database, loads solutions, and runs proof assertions.
- **Study mode**: `./scripts/forge-load.sh <chapter>` resets the database, loads solutions, and leaves the data available for Adminer, DbGate, or psql inspection.
- **Inspect mode**: `./scripts/forge-inspect.sh <chapter>` prints reading order, solution execution order, proof file, dataset story file, and Adminer/DbGate connection notes without changing the database.
- **Quality gate**: `./scripts/check-workshop-quality.sh` catches missing chapter files, too-few solution files, and repeated generic teaching text.

## Proof Style

Proof tests use SQL assertions. They should fail when an important predicate, constraint, or ordering rule is removed. A good proof checks both the row that should appear and the row that must not appear.
