# Break Fix Drills

1. Remove the already-followed exclusion; Ben should appear despite Ada already following Ben.
2. Remove the block exclusion; Cy should appear because Cy has a visible post.
3. Remove `profile_rows.is_searchable = true`; Noor should appear despite being private.
4. Count followers and posts in one joined rowset; Diya should report 6 followers or 6 posts.
5. Remove `creator_id DESC` from ordering; Lina and Maya no longer have a complete stable tie-breaker.
6. Add email to the projection; the shaped-projection proof should fail.

