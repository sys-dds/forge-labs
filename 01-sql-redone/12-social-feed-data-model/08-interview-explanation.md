# Interview Explanation

## Direct answer

I would model posts as authored rows, comments/reactions/reposts as child facts, follows and groups as visibility paths, and blocks/mutes as author eligibility filters.

## Dataset walkthrough

Ada follows Ben and Cy, muted Cy, and blocked Noor. Ben posts 101 and 102 are eligible. Diya post 401 is eligible through Backend Club. Cy 201, Noor 301, Omar 501, Lina 601, and Ben 103 are excluded for different row-level reasons. Ben post 101 has two comments, two reactions, and one repost.

## Query reasoning

The solution builds eligibility branches for followed public, followed followers-only, and shared-group posts, then applies muted/blocked author exclusions and joins separate child count summaries.

## Common mistake

The common mistake is scanning public posts or group posts without Ada's relationship path, which leaks Omar 501 and Lina 601.

## Senior trade-off

Keeping child aggregation separate is more verbose, but it preserves one output row per post and makes Ben 101's counts inspectable.

## Follow-up answer

If replies needed per-viewer hiding later, I would filter comment rows in the comment summary without changing the post-author eligibility rule for Ben 101.

