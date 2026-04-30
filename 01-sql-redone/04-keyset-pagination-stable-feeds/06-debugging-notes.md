# Debugging Notes

Post 106 is the cursor row. "Page two" is not "offset two"; it means continue after the exact row Ada already saw: `(created_at, id) = (10:04, 106)`.

Post 108 arrives at 10:06 after Ada saw page one. Offset pagination counts from the new top of the list, so offset page two returns 106 again. That duplicate tells the user the feed moved underneath the page number.

Post 105 and post 104 share 10:03. `created_at` alone is not a cursor because it cannot say whether the next row after post 105 should include post 104. The id tie-breaker carries that missing position.

Descending comparisons are easy to reverse. With `ORDER BY created_at DESC, id DESC`, the next page uses rows where `(created_at, id)` is less than the cursor pair.

Post 107 and post 106 are still the correct first page before post 108. The fix does not rewrite history; it makes the next request continue from post 106.

