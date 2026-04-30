# Interview Explanation

## Direct answer

I would use a recursive CTE with c1 as the base case, a recursive child join, depth tracking, and a path key for stable display order.

## Dataset walkthrough

Post 100 has root c1, children c2 and c3, c4 under c2, c5 under c4, and separate root c8. Post 200 has c6 and c7. The c1 subtree is c1, c2, c4, c5, then c3.

## Query reasoning

The base term selects c1 for post 100. The recursive term joins comments whose parent is the current row and keeps `child.post_id = thread.post_id`. Depth increments by one, and the path appends each child's sort order.

## Common mistake

The common mistake is starting from all roots. That makes c8 and c6 look valid even though Ada opened c1 on post 100.

## Senior trade-off

Path ordering adds a little query complexity, but it gives the API stable tree order without sorting in application code.

## Follow-up answer

For very deep threads, I would keep the scoped recursive query correct first, then consider max-depth loading or paged child expansion without dropping the post scope predicate.

