# Break Fix Drills

1. Replace the keyset predicate with `OFFSET 2`; post 106 should appear again after post 108 is inserted.
2. Remove `id` from the cursor; after cursor post 105, post 104 should be skipped.
3. Reverse the tuple comparison to `>`; page two after post 106 should jump toward newer rows.
4. Remove `id DESC` from the ordering; posts 105 and 104 no longer have a stable order.
5. Change page size to 3 and use post 105 as the cursor; the next page should start at post 104.

