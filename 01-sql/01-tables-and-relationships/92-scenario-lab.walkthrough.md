# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/01-tables-and-relationships`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/01-tables-and-relationships`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: Ada profile

- Why the row exists: Ada profile is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada profile should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada profile.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada profile behaves differently from a nearby row.
- Interview line: "In Tables And Relationships, Ada profile proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: Ben no settings

- Why the row exists: Ben no settings is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ben no settings should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ben no settings.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ben no settings behaves differently from a nearby row.
- Interview line: "In Tables And Relationships, Ben no settings proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: Ada two posts

- Why the row exists: Ada two posts is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada two posts should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada two posts.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada two posts behaves differently from a nearby row.
- Interview line: "In Tables And Relationships, Ada two posts proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: Ada follows Ben and Cy

- Why the row exists: Ada follows Ben and Cy is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada follows Ben and Cy should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada follows Ben and Cy.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada follows Ben and Cy behaves differently from a nearby row.
- Interview line: "In Tables And Relationships, Ada follows Ben and Cy proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: duplicate profile

- Why the row exists: duplicate profile is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether duplicate profile should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles duplicate profile.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why duplicate profile behaves differently from a nearby row.
- Interview line: "In Tables And Relationships, duplicate profile proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: duplicate preview follow

- Why the row exists: duplicate preview follow is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether duplicate preview follow should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles duplicate preview follow.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why duplicate preview follow behaves differently from a nearby row.
- Interview line: "In Tables And Relationships, duplicate preview follow proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace Ada profile from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace Ben no settings from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace Ada two posts from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace Ada follows Ben and Cy from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace duplicate profile from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace duplicate preview follow from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace Ada profile from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace Ben no settings from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace Ada two posts from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace Ada follows Ben and Cy from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace duplicate profile from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace duplicate preview follow from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace Ada profile from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace Ben no settings from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace Ada two posts from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace Ada follows Ben and Cy from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace duplicate profile from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace duplicate preview follow from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether Ada two posts appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether Ada follows Ben and Cy appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether duplicate profile appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether duplicate preview follow appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether Ada profile appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether Ben no settings appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether Ada two posts appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether Ada follows Ben and Cy appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether duplicate profile appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether duplicate preview follow appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether Ada profile appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether Ben no settings appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether Ada two posts appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether Ada follows Ben and Cy appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether duplicate profile appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether duplicate preview follow appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether Ada profile appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether Ben no settings appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles duplicate profile. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles duplicate preview follow. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles Ada profile. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles Ben no settings. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles Ada two posts. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles Ada follows Ben and Cy. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles duplicate profile. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles duplicate preview follow. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles Ada profile. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles Ben no settings. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles Ada two posts. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles Ada follows Ben and Cy. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles duplicate profile. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles duplicate preview follow. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles Ada profile. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles Ben no settings. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles Ada two posts. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles Ada follows Ben and Cy. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why Ben no settings exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why Ada two posts exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why Ada follows Ben and Cy exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why duplicate profile exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why duplicate preview follow exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why Ada profile exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why Ben no settings exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why Ada two posts exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why Ada follows Ben and Cy exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why duplicate profile exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why duplicate preview follow exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why Ada profile exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why Ben no settings exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why Ada two posts exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why Ada follows Ben and Cy exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why duplicate profile exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why duplicate preview follow exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why Ada profile exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

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
