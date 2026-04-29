# Scenario Lab Walkthrough

This companion file is intentionally dataset-first. It gives you a slow path through the chapter after the proof is green. Use it when you want to turn the SQL from something that runs into something you can explain under review pressure.

## How To Use This Walkthrough

1. Load the chapter with `./scripts/forge-load.sh 01-sql/04-followers-and-social-graph`.
2. Open Adminer or DbGate and inspect the base tables before opening views.
3. Read one row note below, run the related query, and predict the proof assertion.
4. Break the named guard, rerun `./scripts/forge-test.sh 01-sql/04-followers-and-social-graph`, and restore it.
5. Say the interview line without looking at the file.

## Row-To-Proof Ledger

### Ledger 1: Ada following Ben/Cy

- Why the row exists: Ada following Ben/Cy is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ada following Ben/Cy should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ada following Ben/Cy.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ada following Ben/Cy behaves differently from a nearby row.
- Interview line: "In Followers And Social Graph, Ada following Ben/Cy proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 2: Ben mutual

- Why the row exists: Ben mutual is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Ben mutual should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Ben mutual.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Ben mutual behaves differently from a nearby row.
- Interview line: "In Followers And Social Graph, Ben mutual proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 3: Diya suggestion

- Why the row exists: Diya suggestion is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Diya suggestion should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Diya suggestion.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Diya suggestion behaves differently from a nearby row.
- Interview line: "In Followers And Social Graph, Diya suggestion proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 4: Noor blocked

- Why the row exists: Noor blocked is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Noor blocked should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Noor blocked.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Noor blocked behaves differently from a nearby row.
- Interview line: "In Followers And Social Graph, Noor blocked proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 5: Cy muted

- Why the row exists: Cy muted is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Cy muted should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Cy muted.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Cy muted behaves differently from a nearby row.
- Interview line: "In Followers And Social Graph, Cy muted proves that the query is not just returning happy-path rows; it is defending a backend boundary."

### Ledger 6: Theo disconnected

- Why the row exists: Theo disconnected is present so this chapter has a named case that cannot be waved away as sample data.
- What to inspect: find the row in the base table first, then find the view or proof assertion that depends on it.
- Backend question: ask whether Theo disconnected should be returned, rejected, counted, hidden, ranked, or used only as an exclusion control.
- Safety guard: identify the constraint, predicate, ordering key, or aggregate isolation that handles Theo disconnected.
- Break/fix move: remove that guard for one run, read the proof failure, then restore the SQL.
- Senior review note: do not accept a query explanation unless it names why Theo disconnected behaves differently from a nearby row.
- Interview line: "In Followers And Social Graph, Theo disconnected proves that the query is not just returning happy-path rows; it is defending a backend boundary."

## Predicate And Constraint Review

- Review pass 1: trace Ada following Ben/Cy from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 2: trace Ben mutual from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 3: trace Diya suggestion from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 4: trace Noor blocked from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 5: trace Cy muted from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 6: trace Theo disconnected from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 7: trace Ada following Ben/Cy from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 8: trace Ben mutual from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 9: trace Diya suggestion from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 10: trace Noor blocked from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 11: trace Cy muted from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 12: trace Theo disconnected from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 13: trace Ada following Ben/Cy from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 14: trace Ben mutual from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 15: trace Diya suggestion from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 16: trace Noor blocked from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 17: trace Cy muted from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.
- Review pass 18: trace Theo disconnected from seed data to final assertion. Write the one SQL fragment that would cause the wrong behavior if removed.

## Adminer/DbGate Inspection Prompts

- Inspection 1: before opening the view, predict whether Diya suggestion appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 2: before opening the view, predict whether Noor blocked appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 3: before opening the view, predict whether Cy muted appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 4: before opening the view, predict whether Theo disconnected appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 5: before opening the view, predict whether Ada following Ben/Cy appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 6: before opening the view, predict whether Ben mutual appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 7: before opening the view, predict whether Diya suggestion appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 8: before opening the view, predict whether Noor blocked appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 9: before opening the view, predict whether Cy muted appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 10: before opening the view, predict whether Theo disconnected appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 11: before opening the view, predict whether Ada following Ben/Cy appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 12: before opening the view, predict whether Ben mutual appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 13: before opening the view, predict whether Diya suggestion appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 14: before opening the view, predict whether Noor blocked appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 15: before opening the view, predict whether Cy muted appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 16: before opening the view, predict whether Theo disconnected appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 17: before opening the view, predict whether Ada following Ben/Cy appears. Then compare the prediction with the loaded result and explain any absence.
- Inspection 18: before opening the view, predict whether Ben mutual appears. Then compare the prediction with the loaded result and explain any absence.

## Proof-First Study Drills

- Drill 1: make a one-line SQL change that mishandles Cy muted. The proof should fail for a reason you can state in one sentence.
- Drill 2: make a one-line SQL change that mishandles Theo disconnected. The proof should fail for a reason you can state in one sentence.
- Drill 3: make a one-line SQL change that mishandles Ada following Ben/Cy. The proof should fail for a reason you can state in one sentence.
- Drill 4: make a one-line SQL change that mishandles Ben mutual. The proof should fail for a reason you can state in one sentence.
- Drill 5: make a one-line SQL change that mishandles Diya suggestion. The proof should fail for a reason you can state in one sentence.
- Drill 6: make a one-line SQL change that mishandles Noor blocked. The proof should fail for a reason you can state in one sentence.
- Drill 7: make a one-line SQL change that mishandles Cy muted. The proof should fail for a reason you can state in one sentence.
- Drill 8: make a one-line SQL change that mishandles Theo disconnected. The proof should fail for a reason you can state in one sentence.
- Drill 9: make a one-line SQL change that mishandles Ada following Ben/Cy. The proof should fail for a reason you can state in one sentence.
- Drill 10: make a one-line SQL change that mishandles Ben mutual. The proof should fail for a reason you can state in one sentence.
- Drill 11: make a one-line SQL change that mishandles Diya suggestion. The proof should fail for a reason you can state in one sentence.
- Drill 12: make a one-line SQL change that mishandles Noor blocked. The proof should fail for a reason you can state in one sentence.
- Drill 13: make a one-line SQL change that mishandles Cy muted. The proof should fail for a reason you can state in one sentence.
- Drill 14: make a one-line SQL change that mishandles Theo disconnected. The proof should fail for a reason you can state in one sentence.
- Drill 15: make a one-line SQL change that mishandles Ada following Ben/Cy. The proof should fail for a reason you can state in one sentence.
- Drill 16: make a one-line SQL change that mishandles Ben mutual. The proof should fail for a reason you can state in one sentence.
- Drill 17: make a one-line SQL change that mishandles Diya suggestion. The proof should fail for a reason you can state in one sentence.
- Drill 18: make a one-line SQL change that mishandles Noor blocked. The proof should fail for a reason you can state in one sentence.

## Reviewer Checklist

- Checklist 1: can a reviewer see why Ben mutual exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 2: can a reviewer see why Diya suggestion exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 3: can a reviewer see why Noor blocked exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 4: can a reviewer see why Cy muted exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 5: can a reviewer see why Theo disconnected exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 6: can a reviewer see why Ada following Ben/Cy exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 7: can a reviewer see why Ben mutual exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 8: can a reviewer see why Diya suggestion exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 9: can a reviewer see why Noor blocked exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 10: can a reviewer see why Cy muted exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 11: can a reviewer see why Theo disconnected exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 12: can a reviewer see why Ada following Ben/Cy exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 13: can a reviewer see why Ben mutual exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 14: can a reviewer see why Diya suggestion exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 15: can a reviewer see why Noor blocked exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 16: can a reviewer see why Cy muted exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 17: can a reviewer see why Theo disconnected exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.
- Checklist 18: can a reviewer see why Ada following Ben/Cy exists without reading any hidden context? If not, improve the SQL comment or dataset story before moving on.

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
