# Break Fix Drills

1. Remove the mute filter from `ada_home_timeline`; Cy post 201 should appear.
2. Remove the block filter from `ada_home_timeline`; Noor post 301 should appear.
3. Remove `DISTINCT ON (source_event_id)` from the inbox; Maya mention should appear twice.
4. Count all inbox rows as unread; Lina old read notification should inflate the badge.
5. Apply block/mute only when inserting timeline rows; explain why Cy 201 remains if Ada mutes Cy after fanout.
6. Remove the `read_at IS NULL` filter; unread count after reading Maya mention should stay too high.

