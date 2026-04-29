# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/07-window-functions-and-ranking-basics`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/07-window-functions-and-ranking-basics`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: Ada latest 103

- Why the row exists: Ada latest 103 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada latest 103 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada latest 103.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada latest 103 behaves differently from a nearby row.
- Interview line: "In Window Functions And Ranking Basics, Ada latest 103 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: Ben latest 202

- Why the row exists: Ben latest 202 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ben latest 202 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ben latest 202.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ben latest 202 behaves differently from a nearby row.
- Interview line: "In Window Functions And Ranking Basics, Ben latest 202 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: Cy only 301

- Why the row exists: Cy only 301 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Cy only 301 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Cy only 301.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Cy only 301 behaves differently from a nearby row.
- Interview line: "In Window Functions And Ranking Basics, Cy only 301 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: post rank tie

- Why the row exists: post rank tie is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether post rank tie should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles post rank tie.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why post rank tie behaves differently from a nearby row.
- Interview line: "In Window Functions And Ranking Basics, post rank tie proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: author follower tie

- Why the row exists: author follower tie is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether author follower tie should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles author follower tie.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why author follower tie behaves differently from a nearby row.
- Interview line: "In Window Functions And Ranking Basics, author follower tie proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: running total partition

- Why the row exists: running total partition is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether running total partition should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles running total partition.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why running total partition behaves differently from a nearby row.
- Interview line: "In Window Functions And Ranking Basics, running total partition proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace Ada latest 103 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace Ben latest 202 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace Cy only 301 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace post rank tie from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace author follower tie from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace running total partition from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace Ada latest 103 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace Ben latest 202 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace Cy only 301 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace post rank tie from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace author follower tie from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace running total partition from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace Ada latest 103 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace Ben latest 202 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace Cy only 301 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace post rank tie from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace author follower tie from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace running total partition from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether Cy only 301 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether post rank tie appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether author follower tie appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether running total partition appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether Ada latest 103 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether Ben latest 202 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether Cy only 301 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether post rank tie appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether author follower tie appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether running total partition appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether Ada latest 103 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether Ben latest 202 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether Cy only 301 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether post rank tie appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether author follower tie appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether running total partition appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether Ada latest 103 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether Ben latest 202 appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles author follower tie. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles running total partition. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles Ada latest 103. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles Ben latest 202. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles Cy only 301. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles post rank tie. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles author follower tie. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles running total partition. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles Ada latest 103. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles Ben latest 202. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles Cy only 301. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles post rank tie. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles author follower tie. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles running total partition. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles Ada latest 103. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles Ben latest 202. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles Cy only 301. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles post rank tie. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why Ben latest 202 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why Cy only 301 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why post rank tie exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why author follower tie exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why running total partition exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why Ada latest 103 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why Ben latest 202 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why Cy only 301 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why post rank tie exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why author follower tie exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why running total partition exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why Ada latest 103 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why Ben latest 202 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why Cy only 301 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why post rank tie exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why author follower tie exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why running total partition exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why Ada latest 103 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

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
