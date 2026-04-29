# Pagination and Cursors

## Plain-English Concept

A cursor is an anchor in an ordered result set; it should use enough columns to make the order unique.

## Real-World Backend Pattern

Feeds and follower lists need stable next pages while new rows are inserted.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. Offset pagination counts positions and can drift.
2. Keyset pagination asks for rows after the last seen key.
3. created_at alone is not unique, so id is the tie-breaker.
4. The cursor shape returns the keys needed for the next request.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- ordering only by created_at
- offset for changing feeds
- cursor without unique tie-breaker
- using page number as cursor

## Next Unlock

Stable keyset cursors make production feed scrolling possible.
