# Matching SQL Swipes and Mutual Matches

## Plain-English Concept

Swipes are directed actions. Matches and recommendations are derived from those actions plus exclusions.

## Real-World Backend Pattern

Matching begins with SQL exclusions and mutual LIKE detection before any recommendation algorithm exists.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. Profiles and preferences define who can be considered.
2. Swipes record one decision per target.
3. A mutual match is LIKE in both directions.
4. Candidate exclusion removes self, already-swiped, blocked, and inactive users.
5. Preference fit adds age, city, and shared-interest filters before ranking.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- duplicate swipes allowed
- self-swipe allowed
- PASS treated as match
- already-swiped users included
- blocked or inactive users included
- ranking before exclusions

## Next Unlock

Preference-fit candidates become the handoff to later matching/ranking algorithms.
