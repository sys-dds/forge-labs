# Objects, Relationships, Events, Read Models

Product interaction systems usually start with durable objects, then relationship tables, then event history, then read models. Keep the first model boring and correct: primary keys, uniqueness rules, lifecycle states, and query contracts. Add caches or denormalised counters later only when the read path demands it.

Clinics 006-010 make that split visible:

- `posts` plus `follow_edges`, `block_edges`, and `mute_edges` derive a home feed.
- `interaction_events` derive deduped `notifications` and unread state.
- `activity_events` are filtered into user-visible activity, not blindly exposed as audit history.
- `follow_edges`, `user_interests`, `swipe_events`, `matches`, `block_edges`, and `report_events` derive recommendation candidates before ranking.
- The capstone composes these contracts without turning the answer into a large system design.
