# Explain In Interview

## Direct answer
I would solve this with WITH RECURSIVE hierarchy traversal, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
`services` is the root, `sink repair` is deep, `blocked child` sits below disabled `blocked services`, `ghost child` is outside the root, and `cycle a`/`cycle b` form a bad cycle.

## Query reasoning
Start at active `services`, recurse only through active children, carry a visited id path and depth, and order by path text.

## Common mistake
The broken query joins only one level below `services`, so it misses deeper descendants and has no cycle guard.

## Follow-up answer
If cycles are common, keep both a visited path guard and a practical max depth.
