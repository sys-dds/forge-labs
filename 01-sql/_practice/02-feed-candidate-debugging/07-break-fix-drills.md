# Break/Fix Drills

1. Replace the `LEFT JOIN` to comment counts with an `INNER JOIN`.
   - Post `102` disappears because it has zero comments.
   - Fix by joining aggregate counts with `LEFT JOIN` and `coalesce`.

2. Remove the mute predicate.
   - Cy's post `201` appears.
   - Fix by restoring the `NOT EXISTS` check against `user_mutes`.

3. Remove the block predicate.
   - Noor's post `301` appears.
   - Fix by restoring the `NOT EXISTS` check against `user_blocks`.

4. Join `post_likes` and `post_comments` directly before counting.
   - Post `101` reports six joined rows instead of two likes and three comments.
   - Fix by aggregating likes and comments separately before joining them to candidate posts.
