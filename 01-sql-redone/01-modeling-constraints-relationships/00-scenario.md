# Scenario

The marketplace lets buyers follow sellers, block sellers, and save listings. Product support has seen duplicate saves, duplicate profile rows, and self-follows in other systems. This clinic turns those failures into database-owned invariants.

The important idea: a relationship table stores a fact. `saved_listings(user_id, listing_id)` means this user saved this listing. It should not be an array hidden inside `users`, and it should not rely on application code to deduplicate concurrent requests.

