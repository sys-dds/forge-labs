# Profile and User Querying Concept Explainer

## Plain-English Concept
The query is a response contract. Select only public facts the caller may learn. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
email leaks, inflated counts, private profiles in search, and APIs exposing every table change. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada is public, has email, two posts, two followers, and follows one user.
2. ben is public, has one post, one follower, and follows two users.
3. cy is non-searchable so search must skip that row.
4. diya is public with no posts so empty activity still renders.

The positive cases are: Ada profile card returns exact counts; Diya can appear with zero post count; search returns only public matching handles. The negative cases are: email is absent from public profile views; cy is excluded from public search; missing handle returns zero rows. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior separates storage facts from response facts and tests the boundary explicitly. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For profile and user querying, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is email is absent from public profile views, and the proof makes that visible."

## Next Unlock
feed author cards and social graph views in chapter 04.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
