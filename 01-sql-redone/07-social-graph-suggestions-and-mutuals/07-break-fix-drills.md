# Break Fix Drills

1. Reverse `follower_id` and `followee_id` in `ada_following`; Ada should appear to follow Ben's follower set instead of her outgoing set.
2. Remove the already-followed exclusion; Ben, Cy, or Maya should appear as suggestions.
3. Remove the block exclusion; Noor should appear through Cy.
4. Remove `DISTINCT`; Diya should appear once through Ben, once through Cy, and once through Maya.
5. Include incoming followers as suggestions; Omar should appear even though Ada has no outgoing path through Omar.

