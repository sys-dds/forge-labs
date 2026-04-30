# Break Fix Drills

1. Add `u.email` back to `ben_public_profile_card`; the email-column proof should fail for Ben.
2. Remove `profile_rows.is_searchable = true`; Cy should return in Ada-safe search.
3. Remove the block `NOT EXISTS`; Noor should return even though Ada blocked Noor.
4. Join posts and followers directly again; Ben's two visible posts and two followers should inflate.
5. Switch back to count CTEs or subqueries; Ben should return visible_post_count 2, follower_count 2, and following_count 1.

