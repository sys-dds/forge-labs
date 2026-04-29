# Comments and Recursive Queries

## Plain-English Concept

A recursive CTE starts with a base row, repeatedly finds children, and carries depth/path state forward.

## Real-World Backend Pattern

Comment threads and categories are parent-child rows that need recursive expansion into trees.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. Root comments have no parent.
2. Direct replies are one level down.
3. Recursive queries keep joining children to rows already found.
4. Depth tells the UI how far to indent.
5. Path gives deterministic tree order.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- no recursive base case
- no parent foreign key
- path not stable
- recursive query includes wrong post or category scope

## Next Unlock

Recursive CTEs let later backend paths model comments, folders, categories, and org-like hierarchies.
