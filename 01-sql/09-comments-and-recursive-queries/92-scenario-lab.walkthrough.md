# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/09-comments-and-recursive-queries`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/09-comments-and-recursive-queries`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: c1 root

- Why the row exists: c1 root is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether c1 root should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles c1 root.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why c1 root behaves differently from a nearby row.
- Interview line: "In Comments And Recursive Queries, c1 root proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: c2/c3 direct replies

- Why the row exists: c2/c3 direct replies is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether c2/c3 direct replies should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles c2/c3 direct replies.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why c2/c3 direct replies behaves differently from a nearby row.
- Interview line: "In Comments And Recursive Queries, c2/c3 direct replies proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: c4/c5 deep branch

- Why the row exists: c4/c5 deep branch is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether c4/c5 deep branch should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles c4/c5 deep branch.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why c4/c5 deep branch behaves differently from a nearby row.
- Interview line: "In Comments And Recursive Queries, c4/c5 deep branch proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: post 200 exclusion

- Why the row exists: post 200 exclusion is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether post 200 exclusion should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles post 200 exclusion.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why post 200 exclusion behaves differently from a nearby row.
- Interview line: "In Comments And Recursive Queries, post 200 exclusion proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: invalid parent

- Why the row exists: invalid parent is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether invalid parent should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles invalid parent.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why invalid parent behaves differently from a nearby row.
- Interview line: "In Comments And Recursive Queries, invalid parent proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: electronics category tree

- Why the row exists: electronics category tree is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether electronics category tree should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles electronics category tree.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why electronics category tree behaves differently from a nearby row.
- Interview line: "In Comments And Recursive Queries, electronics category tree proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace c1 root from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace c2/c3 direct replies from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace c4/c5 deep branch from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace post 200 exclusion from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace invalid parent from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace electronics category tree from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace c1 root from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace c2/c3 direct replies from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace c4/c5 deep branch from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace post 200 exclusion from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace invalid parent from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace electronics category tree from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace c1 root from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace c2/c3 direct replies from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace c4/c5 deep branch from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace post 200 exclusion from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace invalid parent from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace electronics category tree from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether c4/c5 deep branch appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether post 200 exclusion appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether invalid parent appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether electronics category tree appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether c1 root appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether c2/c3 direct replies appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether c4/c5 deep branch appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether post 200 exclusion appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether invalid parent appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether electronics category tree appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether c1 root appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether c2/c3 direct replies appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether c4/c5 deep branch appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether post 200 exclusion appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether invalid parent appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether electronics category tree appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether c1 root appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether c2/c3 direct replies appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles invalid parent. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles electronics category tree. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles c1 root. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles c2/c3 direct replies. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles c4/c5 deep branch. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles post 200 exclusion. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles invalid parent. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles electronics category tree. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles c1 root. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles c2/c3 direct replies. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles c4/c5 deep branch. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles post 200 exclusion. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles invalid parent. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles electronics category tree. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles c1 root. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles c2/c3 direct replies. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles c4/c5 deep branch. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles post 200 exclusion. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why c2/c3 direct replies exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why c4/c5 deep branch exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why post 200 exclusion exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why invalid parent exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why electronics category tree exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why c1 root exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why c2/c3 direct replies exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why c4/c5 deep branch exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why post 200 exclusion exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why invalid parent exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why electronics category tree exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why c1 root exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why c2/c3 direct replies exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why c4/c5 deep branch exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why post 200 exclusion exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why invalid parent exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why electronics category tree exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why c1 root exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

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
