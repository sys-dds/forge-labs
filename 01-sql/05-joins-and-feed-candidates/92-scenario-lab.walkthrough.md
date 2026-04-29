# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/05-joins-and-feed-candidates`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/05-joins-and-feed-candidates`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: Ben post 101

- Why the row exists: Ben post 101 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ben post 101 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ben post 101.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ben post 101 behaves differently from a nearby row.
- Interview line: "In Joins And Feed Candidates, Ben post 101 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: Ben post 102

- Why the row exists: Ben post 102 is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ben post 102 should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ben post 102.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ben post 102 behaves differently from a nearby row.
- Interview line: "In Joins And Feed Candidates, Ben post 102 proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: Cy muted post

- Why the row exists: Cy muted post is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Cy muted post should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Cy muted post.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Cy muted post behaves differently from a nearby row.
- Interview line: "In Joins And Feed Candidates, Cy muted post proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: Noor blocked post

- Why the row exists: Noor blocked post is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Noor blocked post should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Noor blocked post.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Noor blocked post behaves differently from a nearby row.
- Interview line: "In Joins And Feed Candidates, Noor blocked post proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: Diya not followed

- Why the row exists: Diya not followed is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Diya not followed should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Diya not followed.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Diya not followed behaves differently from a nearby row.
- Interview line: "In Joins And Feed Candidates, Diya not followed proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: post 101 multiplication

- Why the row exists: post 101 multiplication is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether post 101 multiplication should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles post 101 multiplication.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why post 101 multiplication behaves differently from a nearby row.
- Interview line: "In Joins And Feed Candidates, post 101 multiplication proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace Ben post 101 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace Ben post 102 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace Cy muted post from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace Noor blocked post from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace Diya not followed from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace post 101 multiplication from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace Ben post 101 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace Ben post 102 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace Cy muted post from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace Noor blocked post from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace Diya not followed from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace post 101 multiplication from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace Ben post 101 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace Ben post 102 from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace Cy muted post from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace Noor blocked post from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace Diya not followed from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace post 101 multiplication from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether Cy muted post appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether Noor blocked post appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether Diya not followed appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether post 101 multiplication appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether Ben post 101 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether Ben post 102 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether Cy muted post appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether Noor blocked post appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether Diya not followed appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether post 101 multiplication appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether Ben post 101 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether Ben post 102 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether Cy muted post appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether Noor blocked post appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether Diya not followed appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether post 101 multiplication appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether Ben post 101 appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether Ben post 102 appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles Diya not followed. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles post 101 multiplication. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles Ben post 101. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles Ben post 102. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles Cy muted post. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles Noor blocked post. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles Diya not followed. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles post 101 multiplication. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles Ben post 101. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles Ben post 102. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles Cy muted post. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles Noor blocked post. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles Diya not followed. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles post 101 multiplication. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles Ben post 101. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles Ben post 102. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles Cy muted post. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles Noor blocked post. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why Ben post 102 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why Cy muted post exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why Noor blocked post exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why Diya not followed exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why post 101 multiplication exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why Ben post 101 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why Ben post 102 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why Cy muted post exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why Noor blocked post exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why Diya not followed exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why post 101 multiplication exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why Ben post 101 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why Ben post 102 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why Cy muted post exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why Noor blocked post exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why Diya not followed exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why post 101 multiplication exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why Ben post 101 exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

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
