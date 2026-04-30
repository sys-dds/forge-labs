# Scaling Notes

Stay small in this interview slice: model the source rows first, then discuss indexes and read models after correctness.

- Index collection_items(collection_id,item_position).
- Index collection_members(collection_id,user_id,member_state).
- Keep saved_items separate from collection item placement.

Avoid platform infrastructure detours for this clinic.
