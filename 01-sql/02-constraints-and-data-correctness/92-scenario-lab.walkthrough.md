# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/02-constraints-and-data-correctness`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/02-constraints-and-data-correctness`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: Ada unique handle

- Why the row exists: Ada unique handle is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada unique handle should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada unique handle.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada unique handle behaves differently from a nearby row.
- Interview line: "In Constraints And Data Correctness, Ada unique handle proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: Ada follows Ben once

- Why the row exists: Ada follows Ben once is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada follows Ben once should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada follows Ben once.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada follows Ben once behaves differently from a nearby row.
- Interview line: "In Constraints And Data Correctness, Ada follows Ben once proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: duplicate Ada->Ben

- Why the row exists: duplicate Ada->Ben is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether duplicate Ada->Ben should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles duplicate Ada->Ben.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why duplicate Ada->Ben behaves differently from a nearby row.
- Interview line: "In Constraints And Data Correctness, duplicate Ada->Ben proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: Ada self-follow

- Why the row exists: Ada self-follow is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada self-follow should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada self-follow.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada self-follow behaves differently from a nearby row.
- Interview line: "In Constraints And Data Correctness, Ada self-follow proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: missing user 999

- Why the row exists: missing user 999 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether missing user 999 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles missing user 999.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why missing user 999 behaves differently from a nearby row.
- Interview line: "In Constraints And Data Correctness, missing user 999 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: blank handle

- Why the row exists: blank handle is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether blank handle should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles blank handle.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why blank handle behaves differently from a nearby row.
- Interview line: "In Constraints And Data Correctness, blank handle proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace Ada unique handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace Ada follows Ben once from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace duplicate Ada->Ben from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace Ada self-follow from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace missing user 999 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace blank handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace Ada unique handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace Ada follows Ben once from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace duplicate Ada->Ben from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace Ada self-follow from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace missing user 999 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace blank handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace Ada unique handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace Ada follows Ben once from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace duplicate Ada->Ben from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace Ada self-follow from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace missing user 999 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace blank handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether duplicate Ada->Ben appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether Ada self-follow appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether missing user 999 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether blank handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether Ada unique handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether Ada follows Ben once appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether duplicate Ada->Ben appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether Ada self-follow appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether missing user 999 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether blank handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether Ada unique handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether Ada follows Ben once appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether duplicate Ada->Ben appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether Ada self-follow appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether missing user 999 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether blank handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether Ada unique handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether Ada follows Ben once appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles missing user 999. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles blank handle. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles Ada unique handle. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles Ada follows Ben once. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles duplicate Ada->Ben. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles Ada self-follow. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles missing user 999. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles blank handle. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles Ada unique handle. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles Ada follows Ben once. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles duplicate Ada->Ben. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles Ada self-follow. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles missing user 999. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles blank handle. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles Ada unique handle. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles Ada follows Ben once. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles duplicate Ada->Ben. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles Ada self-follow. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why Ada follows Ben once exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why duplicate Ada->Ben exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why Ada self-follow exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why missing user 999 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why blank handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why Ada unique handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why Ada follows Ben once exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why duplicate Ada->Ben exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why Ada self-follow exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why missing user 999 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why blank handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why Ada unique handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why Ada follows Ben once exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why duplicate Ada->Ben exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why Ada self-follow exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why missing user 999 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why blank handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why Ada unique handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

## SQL Guard Quick Reference

- Guard 1: find the primary key in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 2: find the foreign key in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 3: find the CHECK constraint in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 4: find the NOT EXISTS predicate in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 5: find the LEFT JOIN preservation in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 6: find the isolated aggregate in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 7: find the stable ORDER BY in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 8: find the PARTITION BY boundary in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 9: find the visibility filter in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 10: find the exact proof assertion in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 11: find the named seed row in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 12: find the negative case row in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 13: find the break/fix edit in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 14: find the interview explanation in this chapter and write which named dataset row would behave incorrectly without it.
- Guard 15: find the Adminer inspection in this chapter and write which named dataset row would behave incorrectly without it.
