# Design

## What this clinic teaches

Recursive CTEs need a precise base case, a scoped recursive term, depth tracking, and a stable path order.

## Named rows and why each exists

- Post 100 is Ada's target thread.
- Post 200 is unrelated scope.
- c1 is the subtree root for post 100.
- c2 and c3 prove direct replies to c1.
- c4 and c5 prove deeper recursion and depth increments.
- c8 is another root on post 100 that must not appear in c1's subtree.
- c6 and c7 prove post scope isolation.

## Broken query bug

The broken recursive thread starts from all roots, omits depth increments, and does not keep the post 100 scope in the recursive term.

## Exact wrong result from the broken query

`post_100_thread_from_c1` returns c1, c8, c6, c2, c3, c7, c4, and c5 with depth 0 for every row instead of the c1 subtree.

## Correct result from the solution

The c1 subtree returns c1 depth 0, c2 depth 1, c4 depth 2, c5 depth 3, and c3 depth 1 in stable tree order.

## Proof assertions

The proof checks direct replies c2/c3, exact recursive order and depth, c6/c7 exclusion, c8 exclusion, and invalid parent rejection.

## What the learner should notice

The base case chooses the tree; the recursive term walks children; path order keeps parent/child display stable; post scope prevents unrelated comments from leaking.

## Interview explanation target

Explain recursive CTE mechanics, base case versus recursive term, depth/path, stable ordering, and scope safety.

## Row removal checks

- Wrong behavior if removed: without c1, the recursive base case is missing.
- Wrong behavior if removed: without c2, the first child path is not tested.
- Wrong behavior if removed: without c5, deep recursion is not tested.
- Wrong behavior if removed: without c8, same-post non-subtree roots are not tested.
- Wrong behavior if removed: without c6, post 200 scope leakage is not tested.
