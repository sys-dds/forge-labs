# Constraints and Data Correctness

## Plain-English Concept

Constraints are the database final guard when application checks are late, missing, or racing.

## Real-World Backend Pattern

A follow endpoint can receive duplicate or self-follow requests, especially when clients retry or two requests race.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. NOT NULL marks facts the backend must always know.
2. UNIQUE protects lookup identities such as handles.
3. FOREIGN KEY keeps relationships attached to real users.
4. CHECK rejects local nonsense such as self-follow.
5. A composite primary key says the follow pair is the identity.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- app-only duplicate follow check
- no self-follow CHECK
- nullable required handle or email
- missing FK on relationship table

## Next Unlock

Safe follows become trustworthy input for profile counts, followers lists, and social graph traversal.
