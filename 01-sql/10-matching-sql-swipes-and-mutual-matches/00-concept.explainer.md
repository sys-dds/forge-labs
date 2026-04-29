# Matching SQL, Swipes, and Mutual Matches Concept Explainer

## Plain-English Concept
Exclusions are the first matching algorithm. Only then should scoring begin. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
PASS creating matches, already-swiped users reappearing, inactive/blocked candidates scored, and preference filters mixed with safety filters. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada is active age 30 in Glasgow with sql hiking coffee interests.
2. ben is active, overlaps with Ada, and has mutual LIKE.
3. cy is active but Ada passed Cy.
4. diya is active but blocked by Ada.
5. noor is inactive.
6. maya is active, unswiped, Glasgow, and overlaps two interests.
7. omar is active and unswiped but outside preference fit.

The positive cases are: mutual match is Ada-Ben only; raw candidates are Maya and Omar; preference-fit candidate is Maya only; Maya shares two interests. The negative cases are: duplicate and self swipes fail; Cy PASS does not match; Diya blocked excluded; Noor inactive excluded; Ben/Cy already swiped excluded. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior separates safety exclusions from preference scoring and proves both layers. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For matching sql, swipes, and mutual matches, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is duplicate and self swipes fail, and the proof makes that visible."

## Next Unlock
future ranking and matching algorithms after the SQL foundation is reviewed.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
