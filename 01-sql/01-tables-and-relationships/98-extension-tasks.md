# Extension Tasks

## 1. Warm-Up Inspection Task
Load `01-sql/01-tables-and-relationships` and find the named rows: ada has a profile, optional settings, two posts, and preview follows to ben and cy; ben has a profile, one post, and intentionally no settings; cy has a profile and exists as a second follow target. Write down which rows are positive cases and which are exclusions before opening the proof file.

## 2. Add-A-Query Task
Add a nearby view that answers one chapter-specific backend question using the authored dataset. For this chapter, start from: Ada can own multiple posts without duplicating Ada herself. The query should return exact handles, ids, or counts, not a broad dump.

## 3. Add-A-Constraint Or Tighten-Invariant Task
Tighten the invariant that protects: duplicate profile for Ada is rejected. If the schema cannot enforce it directly, write the predicate that acts as the query-level invariant and document why it lives there.

## 4. Break/Fix Task
remove the unique protection on user_profiles.user_id. Confirm the chapter proof fails, restore the correct SQL, and explain which assertion caught the change.

## 5. Dataset Extension Task
Add one new named row that behaves like the edge case in this chapter. Keep the row small, then update the dataset story so another reader knows why it exists.

## 6. Proof Extension Task
Add one exact assertion for the new row. Avoid a proof that only checks count greater than zero; name the expected handle, id, or count.

## 7. Interview Explanation Task
Explain this sentence in your own words: A senior notices that optional settings deserve their own table once the setting group can grow independently from identity.

## 8. Stretch Task
Create a safe and unsafe version of the same query. The unsafe version should fail for one of these reasons: duplicate profile for Ada is rejected; post with missing author is rejected; duplicate Ada to Ben preview follow is rejected.
