# Interview Explanation

## Direct answer

I would model users as the parent table, profiles as one-to-one rows, listings as one-to-many rows owned by sellers, and follows, blocks, and saves as relationship tables with composite keys.

## Dataset walkthrough

Ada has buyer profile 1001. Ben has seller profile 1002 and listings 101 and 102. Cy has seller profile 1003 and listing 201. Ada follows Ben, blocks Cy, and saves Ben listing 101. Diya also saves listing 101, which proves the save fact is per user and per listing. Noor exists without relationship rows.

## Common mistake

The common mistake is trusting application code to deduplicate saves or prevent self-follows. Two concurrent requests can both pass the application check before either write commits.

## Senior trade-off

Composite keys are less flexible than surrogate-only relationship ids, but they encode the invariant directly. I would add surrogate ids only if another table needed to reference one follow or save event as an entity.

