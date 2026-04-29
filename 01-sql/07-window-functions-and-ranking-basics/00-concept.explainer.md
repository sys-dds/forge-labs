# Window Functions and Ranking Inputs Concept Explainer

## Plain-English Concept
A window keeps every row visible while adding context from neighboring rows. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
latest post changing randomly on ties, ranks misunderstood, running totals bleeding across authors, and rank labels treated as final ranking. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada has three posts with a clear latest id.
2. ben has two posts.
3. cy has one post.
4. two posts tie on engagement.
5. two authors tie on follower count.
6. engagement events are ordered per author.

The positive cases are: latest per author returns one exact post each; RANK leaves a gap after a tie; DENSE_RANK does not leave a gap; running total restarts per author. The negative cases are: missing tie-breaker is nondeterministic; running total without partition mixes authors; ranking input is not a final algorithm. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior uses window output as labeled evidence, not as a finished recommendation system. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For window functions and ranking inputs, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is missing tie-breaker is nondeterministic, and the proof makes that visible."

## Next Unlock
stable cursor pagination in chapter 08.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
