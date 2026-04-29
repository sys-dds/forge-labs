# Pagination and Cursors Concept Explainer

## Plain-English Concept
A cursor is the last row boundary, usually made from the same columns used to order results. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
duplicate or skipped feed rows when a new post arrives, unstable timestamp ties, and cursors that cannot identify one row. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. six posts exist before scrolling.
2. two posts share the exact same created_at.
3. a new post appears before offset page two.
4. ids disambiguate timestamp ties.
5. cursor page one returns a documented boundary.

The positive cases are: keyset page one and page two return exact ids; timestamp ties order by id; cursor contains created_at and id. The negative cases are: offset page two differs after insert; created_at alone cannot identify a boundary; DESC comparison must move older than the boundary. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior designs pagination around list movement, not around page numbers. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For pagination and cursors, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is offset page two differs after insert, and the proof makes that visible."

## Next Unlock
recursive comment trees in chapter 09.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
