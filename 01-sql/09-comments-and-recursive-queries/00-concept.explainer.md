# Comments and Recursive Queries Concept Explainer

## Plain-English Concept
Base case chooses the root; recursive step finds children; path turns a tree into a stable list. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
comments from another post leaking into the thread, replies ordered randomly, invalid parent links, and recursion with no clear anchor. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. post 100 has c1 root, c2 and c3 replies, c4 under c2, c5 under c4.
2. post 200 has c6 and c7 to prove scope.
3. categories include Electronics, Computers, Laptops, Phones, Home.

The positive cases are: direct replies to c1 are c2 and c3; recursive thread order is c1,c2,c4,c5,c3; depths are exact; category tree uses same recursion pattern. The negative cases are: post 200 comments are excluded; invalid parent comment fails; unstable path ordering is visible. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior can explain recursive SQL as a loop with a base result and a child expansion. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For comments and recursive queries, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is post 200 comments are excluded, and the proof makes that visible."

## Next Unlock
matching candidate filtering in chapter 10.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
