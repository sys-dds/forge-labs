# Profiles and User Querying

## Plain-English Concept

A backend query usually returns a deliberately shaped response, not table layout.

## Real-World Backend Pattern

A profile page should return a public card, not the raw account table with private fields.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. Keep email in the account row and out of public views.
2. Join user and profile only for fields the public API needs.
3. Use independent count subqueries so post/follow metrics do not multiply each other.
4. Search returns a small card shape, not every profile column.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- SELECT star leaking email
- profile card counts inflated by joins
- private profile returned by search
- returning table shape as API shape

## Next Unlock

Profile cards and counts become the display layer for followers, suggestions, and feeds.
