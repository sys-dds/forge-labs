# Interview Explanation

## Direct answer

I would use keyset pagination with `ORDER BY created_at DESC, id DESC` and a cursor containing both values from the last row the user saw.

## Dataset walkthrough

Ada's first page is post 107 then post 106. Post 108 arrives later at 10:06. Page two after cursor 106 should still be post 105 then post 104, because both are older than `(10:04, 106)`. Post 105 and post 104 tie on timestamp, so id decides the order.

## Common mistake

The common mistake is treating page number as a cursor. Offset counts positions in the current result, and new post 108 changes those positions.

## Senior trade-off

Keyset pagination does not jump to arbitrary page numbers as easily as offset pagination. For scrolling feeds, stable continuation is more important than direct page jumps.

