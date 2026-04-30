# Break/Fix Drills

1. Remove `id` from the `ORDER BY` and cursor.
   - Rows `105` and `104` share the same timestamp, so their order is no longer fully defined.
   - Fix by ordering and filtering with `(created_at, id)`.

2. Reverse the descending cursor comparison.
   - The next page moves toward newer rows instead of older rows.
   - Fix by using `<` for a descending `(created_at, id)` order.

3. Use `OFFSET 2` after inserting post `108`.
   - Page two repeats post `106`.
   - Fix by continuing after the last seen row instead of counting positions.
