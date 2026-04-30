# Break Fix Drills

1. Remove `post_id = 100` from the base case; c6 should enter the thread.
2. Start from `parent_id IS NULL` instead of c1; c8 should appear even though Ada opened c1.
3. Remove `thread.depth + 1`; c4 and c5 should lose their depth.
4. Order by `comment_id`; c3 can appear before c4 and c5, breaking tree display.
5. Add `WHERE thread.depth < 2` in the recursive term; c5 should disappear as a deliberate max-depth cap.

