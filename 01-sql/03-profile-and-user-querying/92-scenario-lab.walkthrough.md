# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/03-profile-and-user-querying`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/03-profile-and-user-querying`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: Ada public card

- Why the row exists: Ada public card is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada public card should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada public card.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada public card behaves differently from a nearby row.
- Interview line: "In Profile And User Querying, Ada public card proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: Ben public card

- Why the row exists: Ben public card is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ben public card should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ben public card.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ben public card behaves differently from a nearby row.
- Interview line: "In Profile And User Querying, Ben public card proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: Cy non-searchable

- Why the row exists: Cy non-searchable is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Cy non-searchable should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Cy non-searchable.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Cy non-searchable behaves differently from a nearby row.
- Interview line: "In Profile And User Querying, Cy non-searchable proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: Diya zero posts

- Why the row exists: Diya zero posts is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Diya zero posts should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Diya zero posts.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Diya zero posts behaves differently from a nearby row.
- Interview line: "In Profile And User Querying, Diya zero posts proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: email hidden

- Why the row exists: email hidden is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether email hidden should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles email hidden.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why email hidden behaves differently from a nearby row.
- Interview line: "In Profile And User Querying, email hidden proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: missing handle

- Why the row exists: missing handle is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether missing handle should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles missing handle.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why missing handle behaves differently from a nearby row.
- Interview line: "In Profile And User Querying, missing handle proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace Ada public card from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace Ben public card from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace Cy non-searchable from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace Diya zero posts from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace email hidden from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace missing handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace Ada public card from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace Ben public card from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace Cy non-searchable from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace Diya zero posts from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace email hidden from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace missing handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace Ada public card from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace Ben public card from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace Cy non-searchable from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace Diya zero posts from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace email hidden from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace missing handle from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether Cy non-searchable appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether Diya zero posts appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether email hidden appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether missing handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether Ada public card appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether Ben public card appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether Cy non-searchable appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether Diya zero posts appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether email hidden appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether missing handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether Ada public card appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether Ben public card appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether Cy non-searchable appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether Diya zero posts appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether email hidden appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether missing handle appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether Ada public card appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether Ben public card appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles email hidden. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles missing handle. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles Ada public card. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles Ben public card. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles Cy non-searchable. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles Diya zero posts. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles email hidden. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles missing handle. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles Ada public card. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles Ben public card. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles Cy non-searchable. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles Diya zero posts. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles email hidden. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles missing handle. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles Ada public card. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles Ben public card. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles Cy non-searchable. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles Diya zero posts. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why Ben public card exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why Cy non-searchable exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why Diya zero posts exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why email hidden exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why missing handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why Ada public card exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why Ben public card exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why Cy non-searchable exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why Diya zero posts exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why email hidden exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why missing handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why Ada public card exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why Ben public card exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why Cy non-searchable exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why Diya zero posts exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why email hidden exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why missing handle exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why Ada public card exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

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
