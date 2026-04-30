# Debugging Notes

Ben post 101 is the valid fanout row in `home_timeline_items`; Ada follows Ben and has not muted or blocked Ben.

Cy post 201 is present in the timeline table, but Ada muted Cy. The read query still needs the mute filter because read models can contain stale or bad rows.

Noor post 301 is present in the timeline table, but Ada blocked Noor. A fanout table is not a permission system by itself.

Ben notification `evt-ben-comment` and Diya notification `evt-diya-like` are unread rows that should count before and after Maya is read.

Maya notification `evt-maya-mention` appears twice with the same source_event_id. The inbox should display it once, and reading that source event should reduce unread count by one.

Lina notification `evt-lina-old` is already read. It can appear in the inbox history, but it must not count toward Ada's unread badge.

The clinic uses tables that prepare for later infrastructure paths, but the SQL lesson here is still about row shape, dedupe, and read-state filtering.

