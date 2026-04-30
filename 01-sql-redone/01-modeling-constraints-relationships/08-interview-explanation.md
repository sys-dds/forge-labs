# Interview Explanation

## Direct answer

I would model users as the parent table, profiles as one-to-one rows, listings as one-to-many rows owned by sellers, and follows, blocks, and saves as relationship tables with composite keys.

## Dataset walkthrough

Ada has buyer profile 1001. Ben has seller profile 1002 and listings 101 and 102. Cy has seller profile 1003 and listing 201. Ada follows Ben, blocks Cy, and saves Ben listing 101. Diya also saves listing 101, which proves the save fact is per user and per listing. Noor exists without relationship rows.

## Query reasoning

The solution keeps users as the parent table, makes profiles unique per user, requires listings to reference sellers, and models follows, blocks, and saves with composite keys plus self-action checks.

## Common mistake

The common mistake is trusting application code to deduplicate saves or prevent self-follows. Two concurrent requests can both pass the application check before either write commits.

## Senior trade-off

Composite keys are less flexible than surrogate-only relationship ids, but they encode the invariant directly. I would add surrogate ids only if another table needed to reference one follow or save event as an entity.

## Follow-up answer

If saves later needed timestamps or notification rows, I would keep `(user_id, listing_id)` unique and add columns or a surrogate reference without allowing duplicate Ada saves for Ben listing 101.
