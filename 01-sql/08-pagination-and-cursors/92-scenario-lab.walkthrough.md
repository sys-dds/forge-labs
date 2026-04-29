# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/08-pagination-and-cursors`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/08-pagination-and-cursors`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: post 106 newest

- Why the row exists: post 106 newest is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether post 106 newest should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles post 106 newest.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why post 106 newest behaves differently from a nearby row.
- Interview line: "In Pagination And Cursors, post 106 newest proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: timestamp tie 105/104

- Why the row exists: timestamp tie 105/104 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether timestamp tie 105/104 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles timestamp tie 105/104.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why timestamp tie 105/104 behaves differently from a nearby row.
- Interview line: "In Pagination And Cursors, timestamp tie 105/104 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: new post 107

- Why the row exists: new post 107 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether new post 107 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles new post 107.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why new post 107 behaves differently from a nearby row.
- Interview line: "In Pagination And Cursors, new post 107 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: cursor row 104

- Why the row exists: cursor row 104 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether cursor row 104 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles cursor row 104.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why cursor row 104 behaves differently from a nearby row.
- Interview line: "In Pagination And Cursors, cursor row 104 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: offset duplicate

- Why the row exists: offset duplicate is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether offset duplicate should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles offset duplicate.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why offset duplicate behaves differently from a nearby row.
- Interview line: "In Pagination And Cursors, offset duplicate proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: DESC comparison

- Why the row exists: DESC comparison is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether DESC comparison should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles DESC comparison.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why DESC comparison behaves differently from a nearby row.
- Interview line: "In Pagination And Cursors, DESC comparison proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace post 106 newest from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace timestamp tie 105/104 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace new post 107 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace cursor row 104 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace offset duplicate from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace DESC comparison from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace post 106 newest from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace timestamp tie 105/104 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace new post 107 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace cursor row 104 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace offset duplicate from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace DESC comparison from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace post 106 newest from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace timestamp tie 105/104 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace new post 107 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace cursor row 104 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace offset duplicate from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace DESC comparison from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether new post 107 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether cursor row 104 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether offset duplicate appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether DESC comparison appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether post 106 newest appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether timestamp tie 105/104 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether new post 107 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether cursor row 104 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether offset duplicate appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether DESC comparison appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether post 106 newest appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether timestamp tie 105/104 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether new post 107 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether cursor row 104 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether offset duplicate appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether DESC comparison appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether post 106 newest appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether timestamp tie 105/104 appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles offset duplicate. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles DESC comparison. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles post 106 newest. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles timestamp tie 105/104. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles new post 107. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles cursor row 104. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles offset duplicate. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles DESC comparison. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles post 106 newest. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles timestamp tie 105/104. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles new post 107. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles cursor row 104. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles offset duplicate. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles DESC comparison. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles post 106 newest. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles timestamp tie 105/104. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles new post 107. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles cursor row 104. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why timestamp tie 105/104 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why new post 107 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why cursor row 104 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why offset duplicate exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why DESC comparison exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why post 106 newest exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why timestamp tie 105/104 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why new post 107 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why cursor row 104 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why offset duplicate exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why DESC comparison exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why post 106 newest exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why timestamp tie 105/104 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why new post 107 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why cursor row 104 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why offset duplicate exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why DESC comparison exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why post 106 newest exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

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
