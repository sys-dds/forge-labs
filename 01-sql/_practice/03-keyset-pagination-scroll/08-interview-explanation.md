# Interview Explanation

Cursor pagination means "continue after the last row I already showed," not "go to page number N."

For a descending feed, the cursor needs every column that makes the order stable. Here that is `(created_at, id)`. When a new post arrives above Ada's cursor, keyset page two still starts after post `106`. Offset pagination counts positions, so the new row shifts the list and can repeat or skip posts.
