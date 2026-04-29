# Joins and Feed Candidates

## Plain-English Concept

Joins combine facts, but candidate generation also needs anti-joins that exclude unsafe or muted rows.

## Real-World Backend Pattern

A feed cannot be ranked until SQL gathers posts the viewer is allowed to see.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. INNER JOIN finds posts from followed authors.
2. LEFT JOIN keeps rows when optional metrics are absent.
3. Self joins compare rows in the same table.
4. Anti joins remove blocked or muted authors.
5. Metrics joins can multiply rows, so counts need isolated aggregation.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- accidental inner join removing rows
- row multiplication from likes/comments
- feed candidates include blocked or muted users
- ranking before candidate filtering

## Next Unlock

Candidate posts plus relationship metadata become raw input for metrics and ranking.
