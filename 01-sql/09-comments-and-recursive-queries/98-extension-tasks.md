# Extension Tasks

## 1. Warm-Up Inspection Task
Load `01-sql/09-comments-and-recursive-queries` and find the named rows: post 100 has c1 root, c2 and c3 replies, c4 under c2, c5 under c4; post 200 has c6 and c7 to prove scope; categories include Electronics, Computers, Laptops, Phones, Home. Write down which rows are positive cases and which are exclusions before opening the proof file.

## 2. Add-A-Query Task
Add a nearby view that answers one chapter-specific backend question using the authored dataset. For this chapter, start from: direct replies to c1 are c2 and c3. The query should return exact handles, ids, or counts, not a broad dump.

## 3. Add-A-Constraint Or Tighten-Invariant Task
Tighten the invariant that protects: post 200 comments are excluded. If the schema cannot enforce it directly, write the predicate that acts as the query-level invariant and document why it lives there.

## 4. Break/Fix Task
remove post_id scope. Confirm the chapter proof fails, restore the correct SQL, and explain which assertion caught the change.

## 5. Dataset Extension Task
Add one new named row that behaves like the edge case in this chapter. Keep the row small, then update the dataset story so another reader knows why it exists.

## 6. Proof Extension Task
Add one exact assertion for the new row. Avoid a proof that only checks count greater than zero; name the expected handle, id, or count.

## 7. Interview Explanation Task
Explain this sentence in your own words: A senior can explain recursive SQL as a loop with a base result and a child expansion.

## 8. Stretch Task
Create a safe and unsafe version of the same query. The unsafe version should fail for one of these reasons: post 200 comments are excluded; invalid parent comment fails; unstable path ordering is visible.
