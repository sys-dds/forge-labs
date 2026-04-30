# Visibility And User Controls

Visibility and controls are query contracts over source rows.

- Audience visibility uses `posts`, `friendships`, `audience_groups`, `audience_group_members`, and `block_edges`.
- Sharing uses `reposts` and `quote_reposts` that point back to original `posts`.
- Saves use `bookmarks` as private user state.
- Controls use `hide_events`, `mute_edges`, `report_events`, and `preference_feedback_events`.

The important trap is scope: a hide is viewer-specific, a report is review evidence, a save is private, and a block overrides otherwise valid visibility.
