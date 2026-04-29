# Aggregation and Counts

## Plain-English Concept

Aggregation compresses many rows into one metric, but the WHERE/JOIN shape decides what gets counted.

## Real-World Backend Pattern

Profile pages, feeds, and ranking inputs need counts that respect hidden posts and deleted comments.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. COUNT posts for profile summaries.
2. Count followers by grouping on followee_id.
3. Use DISTINCT when joining likes and comments together.
4. Filter hidden/deleted rows before they become metrics.
5. Use HAVING when the filter depends on an aggregate.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- counting hidden or deleted rows
- COUNT(*) after joins inflating counts
- using WHERE instead of HAVING for aggregate filters
- missing DISTINCT when counting many-to-many activity

## Next Unlock

Counts and grouped metrics become ranking features in the next chapter.
