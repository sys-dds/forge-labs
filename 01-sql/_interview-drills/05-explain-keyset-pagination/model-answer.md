# Model Answer

After page one shows `107,106`, the cursor is post `106` with `(created_at, id)`. If post `108` arrives above it, page two still asks for rows less than that cursor in descending order, so it returns `105,104` instead of repeating `106`.
