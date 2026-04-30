# Debugging Notes

Ada profile 1001 is the row that exposes the duplicate profile risk. Without `profiles.user_id` being unique, a retry can create another Ada buyer profile and every profile-card query now has two competing facts for one user.

Ada saving Ben listing 101 and Diya saving Ben listing 101 prove why the primary key belongs on `(user_id, listing_id)`. A unique key on only `listing_id` would reject Diya; no key at all would allow Ada to save listing 101 twice.

Ada following Ben is a many-to-many fact: buyer 1 follows seller 2. Ada blocking Cy is the same shape with a different meaning: buyer 1 blocks seller 3. Composite keys match the business fact and make concurrent duplicate requests lose at the database boundary.

Noor is useful because Noor has no relationship rows. Queries must not require every user to have follows, blocks, listings, or saves before the account can exist.

Saved listings are not an array on `users` because each saved row needs foreign keys to both the saver and the listing. An array would make Ben listing 101 harder to protect, harder to join, and easier to duplicate under concurrent writes.

