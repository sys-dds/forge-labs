# Break/Fix Drills

1. Remove the already-followed exclusion.
   - Ben or Cy can leak into suggestions.
   - Fix by restoring the anti-join against Ada's existing follows.

2. Remove the blocked exclusion.
   - Noor appears even though Ada blocked Noor.
   - Fix by restoring the `NOT EXISTS` check against `user_blocks`.

3. Reverse follower and followee direction in the second hop.
   - The query stops answering "people followed by people Ada follows."
   - Fix by joining `second_hop.follower_id` to Ada's first-degree followees.

4. Remove `DISTINCT`.
   - Diya appears twice because both Ben and Cy follow Diya.
   - Fix by deduplicating the final candidate set.
