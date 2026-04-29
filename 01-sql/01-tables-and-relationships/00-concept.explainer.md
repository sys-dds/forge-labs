# Tables and Relationships Concept Explainer

## Plain-English Concept
A table is a domain claim before it is storage. Cardinality is part of the API contract. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
duplicate profile rows and orphaned posts. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada has a profile, optional settings, two posts, and preview follows to ben and cy.
2. ben has a profile, one post, and intentionally no settings.
3. cy has a profile and exists as a second follow target.
4. diya has a profile and proves the model supports users before they post or receive settings.

The positive cases are: Ada can own multiple posts without duplicating Ada herself; Ben can exist without a settings row; Ada can follow Ben and Cy as two separate relationship facts. The negative cases are: duplicate profile for Ada is rejected; post with missing author is rejected; duplicate Ada to Ben preview follow is rejected. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior notices that optional settings deserve their own table once the setting group can grow independently from identity. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For tables and relationships, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is duplicate profile for Ada is rejected, and the proof makes that visible."

## Next Unlock
constraint-backed correctness in chapter 02.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
