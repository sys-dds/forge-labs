# Product Interaction Pattern Map

- Objects: `users`, `profiles`, `posts`, `comments`, and `user_profiles` are the durable things.
- Relationships: `follow_edges`, `friendships`, `block_edges`, `mute_edges`, and `matches` describe links or suppression between people.
- Events: `swipe_events`, `interaction_events`, `activity_events`, `report_events`, and reaction history show what happened over time.
- Counters: follower counts, following counts, likes, comments, replies, unread notifications, and matches can be derived first and materialised later.
- Candidate/read models: home feed rows, notification rows, activity feed rows, and recommendation candidates are contracts derived from objects, relationships, and events.
- Counter/read models: post count rows, user count rows, notification count rows, and drift checks are derived from source-of-truth interaction tables.
- User controls: hide events, mute edges, report events, preference feedback, bookmarks, reposts, and quote reposts are product state with viewer-specific semantics.
- Safety contracts: `report_events`, `report_evidence`, `review_queue_items`, `policy_decisions`, `policy_treatments`, `appeals`, `audit_log`, `abuse_signal_events`, and `trust_score_components` explain why content is allowed, reviewed, downranked, hidden, removed, or restored.
- Marketplace contracts: `creators`, `exposure_budget_windows`, `buyer_intents`, `listings`, `seller_quality_components`, `offers`, `bookings`, `local_supply_snapshots`, `local_demand_snapshots`, and `marketplace_treatments` explain exposure, relevance, quality, availability, and risk outcomes.
- Messaging contracts: `conversations`, `conversation_participants`, `messages`, `message_delivery_states`, `message_read_receipts`, `message_deletions`, `conversation_user_settings`, and `message_reports` explain visibility, unread counts, inbox ordering, mutes, blocks, and report review outcomes.
- Read models: every clinic uses `05-verification-query.sql` as a small contract for the screen or API read path.
