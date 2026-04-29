# Constraints and Data Correctness

## Plain-English Concept

Constraints turn assumptions into enforced rules. They are the database version of never trusting every caller to behave perfectly.

## Real-World Backend Pattern

A follow relationship is safe because the database has the final constraint, not because app code checked first.

## Mental Model

Rows are backend facts. Tables store facts, constraints protect facts, relationships connect facts, and queries shape facts into the result or candidate set the application needs.

## When To Use It

Use constraints for invariants that must stay true under concurrent requests.

## When Not To Use It

Do not rely only on service-layer checks for uniqueness, ownership, or relationship validity.

## Interview Explanation

I use constraints as the final guard: NOT NULL for required facts, UNIQUE for identity, CHECK for local rules, FOREIGN KEY for valid references, and composite primary keys for relationship uniqueness.

## Next Unlock

constraints unlock safe concurrent backend behavior later
