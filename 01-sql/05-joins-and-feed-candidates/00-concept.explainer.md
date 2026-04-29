# Joins and Feed Candidates Concept Explainer

## Plain-English Concept
Eligible rows first, scoring later. Joins are policy, not just data retrieval. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
blocked posts entering ranking, muted authors appearing, zero-comment posts disappearing, and engagement inflated by likes times comments. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada follows ben, cy, and noor.
2. ada mutes cy and blocks noor.
3. diya is not followed.
4. ben posts 101 and 102.
5. cy post 201, noor post 301, diya post 401.
6. post 101 has two likes and three comments.

The positive cases are: feed candidates are Ben posts 101 and 102; post 102 survives despite zero comments; author profile fields are attached. The negative cases are: cy is excluded by mute; noor is excluded by block; diya is excluded because Ada does not follow her; bad multiplication query inflates post 101. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior checks candidate eligibility before debating ranking math. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For joins and feed candidates, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is cy is excluded by mute, and the proof makes that visible."

## Next Unlock
aggregation and metrics in chapter 06.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
