# Followers and Social Graph Concept Explainer

## Plain-English Concept
follower_id is the actor/source; followee_id is the target. Every traversal must say which direction it walks. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
suggesting blocked users, recommending yourself, showing already-followed accounts, or deleting a follow when the user only meant mute. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada follows ben and cy.
2. ben follows ada and diya.
3. cy follows diya and noor.
4. diya and noor follow ada.
5. theo is disconnected.
6. ada blocks noor and mutes cy.

The positive cases are: Ada following is ben and cy; Ada followers are ben, diya, and noor; Ada mutual follows are ben; Ada suggestions are diya only. The negative cases are: noor is reachable but blocked; cy remains followed but hidden from feed-style output; theo never appears accidentally. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior reads a graph query by narrating each edge hop and each exclusion. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For followers and social graph, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is noor is reachable but blocked, and the proof makes that visible."

## Next Unlock
feed candidate generation in chapter 05.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
