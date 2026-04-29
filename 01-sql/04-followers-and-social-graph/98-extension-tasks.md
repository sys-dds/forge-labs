# Extension Tasks

## 1. Warm-Up Inspection Task
Load `01-sql/04-followers-and-social-graph` and find the named rows: ada follows ben and cy; ben follows ada and diya; cy follows diya and noor. Write down which rows are positive cases and which are exclusions before opening the proof file.

## 2. Add-A-Query Task
Add a nearby view that answers one chapter-specific backend question using the authored dataset. For this chapter, start from: Ada following is ben and cy. The query should return exact handles, ids, or counts, not a broad dump.

## 3. Add-A-Constraint Or Tighten-Invariant Task
Tighten the invariant that protects: noor is reachable but blocked. If the schema cannot enforce it directly, write the predicate that acts as the query-level invariant and document why it lives there.

## 4. Break/Fix Task
reverse follower_id and followee_id in followers query. Confirm the chapter proof fails, restore the correct SQL, and explain which assertion caught the change.

## 5. Dataset Extension Task
Add one new named row that behaves like the edge case in this chapter. Keep the row small, then update the dataset story so another reader knows why it exists.

## 6. Proof Extension Task
Add one exact assertion for the new row. Avoid a proof that only checks count greater than zero; name the expected handle, id, or count.

## 7. Interview Explanation Task
Explain this sentence in your own words: A senior reads a graph query by narrating each edge hop and each exclusion.

## 8. Stretch Task
Create a safe and unsafe version of the same query. The unsafe version should fail for one of these reasons: noor is reachable but blocked; cy remains followed but hidden from feed-style output; theo never appears accidentally.
