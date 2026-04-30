# Debugging Notes

Ben's email `ben-private@example.test` leaking from `ben_public_profile_card` is an API boundary bug: the public endpoint should not expose private database fields just because the table has them.

Ben has posts 201, 202, and hidden 203 plus followers Ada and Maya. The broken join combines Ben's three post rows with two follower rows, so `COUNT(post_rows.id)` and `COUNT(follower_rows.follower_id)` both report 6.

Cy appears in the broken `ada_safe_profile_search` even though Cy's profile row has `is_searchable = false`. Removing that predicate turns an opt-out row into a public result.

Noor appears in the broken search even though Ada has block row `(1, 5)`. That block is viewer-specific, so a global public profile flag is not enough.

Diya has a searchable profile and zero posts. Diya proves the endpoint should still render a public profile when activity counts are zero.

Maya follows Ben, likes Ben post 201, and comments on Ben post 202. Those rows prove engagement can exist around Ben without becoming public profile columns or multiplying Ben's follower count.
