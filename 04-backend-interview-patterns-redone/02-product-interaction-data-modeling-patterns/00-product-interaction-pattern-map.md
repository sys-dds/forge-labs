# Product Interaction Pattern Map

- Objects: `users`, `profiles`, `posts`, `comments`, and `user_profiles` are the durable things.
- Relationships: `follow_edges`, `friendships`, `user_blocks`, and `matches` describe links between people.
- Events: `swipe_events`, `report_events`, and reaction history show what happened over time.
- Counters: follower counts, following counts, likes, comments, replies, and matches can be derived first and materialised later.
- Read models: every clinic uses `05-verification-query.sql` as a small contract for the screen or API read path.
