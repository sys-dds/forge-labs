# Extension Tasks

## 1. Warm-Up Inspection Task
Load `01-sql/10-matching-sql-swipes-and-mutual-matches` and find the named rows: ada is active age 30 in Glasgow with sql hiking coffee interests; ben is active, overlaps with Ada, and has mutual LIKE; cy is active but Ada passed Cy. Write down which rows are positive cases and which are exclusions before opening the proof file.

## 2. Add-A-Query Task
Add a nearby view that answers one chapter-specific backend question using the authored dataset. For this chapter, start from: mutual match is Ada-Ben only. The query should return exact handles, ids, or counts, not a broad dump.

## 3. Add-A-Constraint Or Tighten-Invariant Task
Tighten the invariant that protects: duplicate and self swipes fail. If the schema cannot enforce it directly, write the predicate that acts as the query-level invariant and document why it lives there.

## 4. Break/Fix Task
treat any reciprocal swipe as match. Confirm the chapter proof fails, restore the correct SQL, and explain which assertion caught the change.

## 5. Dataset Extension Task
Add one new named row that behaves like the edge case in this chapter. Keep the row small, then update the dataset story so another reader knows why it exists.

## 6. Proof Extension Task
Add one exact assertion for the new row. Avoid a proof that only checks count greater than zero; name the expected handle, id, or count.

## 7. Interview Explanation Task
Explain this sentence in your own words: A senior separates safety exclusions from preference scoring and proves both layers.

## 8. Stretch Task
Create a safe and unsafe version of the same query. The unsafe version should fail for one of these reasons: duplicate and self swipes fail; Cy PASS does not match; Diya blocked excluded; Noor inactive excluded; Ben/Cy already swiped excluded.
