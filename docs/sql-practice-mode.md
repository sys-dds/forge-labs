# SQL Practice Mode

SQL practice mode turns chapter concepts into local backend drills. A pack loads a named scenario dataset, exposes starter views, runs a solution, proves exact behavior, and gives you break/fix drills that should make the proof fail.

## Chapter Mode vs Practice Mode

Use chapter mode when you are learning the concept for the first time. Chapter folders explain the idea, show several solution files, and prove the chapter as a sequence.

Use practice mode when you want to operate the idea. A practice pack is narrower: one scenario, one dataset, one final behavior, and a proof file that checks positive rows, excluded rows, edge rows, and common mistakes.

## Commands

Start the stack:

```bash
./scripts/forge-up.sh sql
```

List packs:

```bash
./scripts/forge-list-practice.sh
```

Inspect a pack:

```bash
./scripts/forge-inspect-practice.sh 01-sql/_practice/01-social-graph-suggestions
```

Load a pack for manual study:

```bash
./scripts/forge-load-practice.sh 01-sql/_practice/01-social-graph-suggestions
```

Run the solution and proof tests:

```bash
./scripts/forge-test-practice.sh 01-sql/_practice/01-social-graph-suggestions
```

Reset:

```bash
./scripts/forge-reset-practice.sh
```

## Inspecting Data

After loading a pack, open Adminer at `http://localhost:8081` or DbGate at `http://localhost:8082`.

Connection values:

- database: `forge_labs`
- user: `forge_labs`
- password: `forge_labs`
- local SQL client host: `localhost`
- DbGate container host: `forge-labs-postgres`

Read `06-expected-results.md` beside the tables. The expected-results file names the rows that should appear, the rows that must be excluded, and the edge case the proof is defending.

## Break/Fix Loop

Open `04-solution.sql`, make one change from `07-break-fix-drills.md`, and rerun:

```bash
./scripts/forge-test-practice.sh <practice-pack>
```

The proof should fail with a specific exception. Restore the predicate, join, cursor comparison, or constraint and rerun the proof. Reset whenever the database state gets noisy.

## After Practice

Move to gauntlet mode when the practice solution makes sense. Gauntlets start from realistic broken SQL and force you to connect a wrong named row to the bug. After gauntlets, use mini take-homes for assessment, interview drills for out-loud explanation, and self-assessment to decide whether to revisit SQL or move toward PostgreSQL-specific work.
