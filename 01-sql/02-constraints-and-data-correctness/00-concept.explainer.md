# Constraints and Data Correctness Concept Explainer

## Plain-English Concept
Application validation improves messages. Database constraints preserve truth. In this chapter, SQL is the place where the backend writes down that idea as durable rows and executable rules.

## The Real Backend Bug This Prevents
duplicate follows, self-follows, missing users, and invalid handles. That bug is easy to miss in a happy-path demo because the first query returns something plausible. The authored dataset includes rows that make the broken version visibly wrong.

## Dataset Walkthrough
1. ada and ben have unique lower-case handles.
2. ada follows ben once.
3. cy and diya exist so invalid and valid relationship attempts are distinguishable.
4. profiles are tied to existing users only.

The positive cases are: Ada to Ben follow is stored exactly once; profiles point at real users; handles are nonblank and lower-case. The negative cases are: duplicate Ada to Ben follow fails; Ada to Ada self-follow fails; follow to user 999 fails; profile for user 999 fails. Keep those lists beside you when reading the SQL; each important predicate should map to one of them.

## Step-By-Step Query Reasoning
Start with the table that owns the durable fact. Join only when a second fact is required. Add exclusions before presenting a row as eligible. Aggregate in isolation when counts can be duplicated. Order with enough columns to make the result deterministic. Finally, read the proof file and identify the assertion that would fail if the key predicate disappeared.

## Senior Mental Model
A senior asks which invariant survives two web workers racing each other. A beginner often asks, "does the query return rows?" A senior asks, "which rows are intentionally absent, and which invariant makes that absence reliable?"

## Beginner Trap
The trap in this chapter is believing the sample output is the lesson. The real lesson is why the row that did not appear was excluded, why the duplicate could not be inserted, or why the count did not inflate.

## Interview Phrasing Unique To This Chapter
"For constraints and data correctness, I would first name the durable facts in the dataset, then point to the exact constraint or predicate that protects the dangerous case. In this chapter the dangerous case is duplicate Ada to Ben follow fails, and the proof makes that visible."

## Next Unlock
safe public profile query shaping in chapter 03.

## Study Check
Before moving on, point to one row that should appear and one row that should not appear. Then point to the exact SQL fragment responsible for each outcome. If you cannot do that yet, reload the chapter in study mode and inspect the base tables again. This check keeps the lesson dataset-first: the proof is not merely green, it is explainable from named rows.
