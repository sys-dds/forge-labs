# Aggregation and Counts Concept Explainer

## Plain-English Concept
Aggregation collapses rows; decide the entity you want one output row for before writing the join. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
hidden posts counted as visible, deleted comments counted as live discussion, and likes inflated by joins. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada has two visible posts and one hidden post.
2. ben has one visible post.
3. cy has no posts.
4. diya has one hidden-style post.
5. Ada post A1 has two likes, two visible comments, and one deleted comment.
6. Ben and Cy follow Ada.

The positive cases are: Ada visible post count is two; A1 visible comment count is two; Ben has three likes on one post; HAVING returns authors above threshold. The negative cases are: hidden posts are excluded; deleted comments are excluded; direct joined count is larger than distinct count. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior treats metric queries as product logic with testable exclusions. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For aggregation and counts, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is hidden posts are excluded, and the proof makes that visible."

## Next Unlock
window functions and ranking input preparation in chapter 07.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
