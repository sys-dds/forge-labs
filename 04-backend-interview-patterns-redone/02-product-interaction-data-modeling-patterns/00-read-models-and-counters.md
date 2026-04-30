# Read Models And Counters

Read models are useful display state, not the source of truth.

- Source rows: `post_reactions`, `comments`, `follow_edges`, `notifications`, `bookmarks`, and `reposts`.
- Read-model rows: `post_count_read_models`, `user_count_read_models`, and `notification_count_read_models`.
- Drift evidence: compare source-derived counts with stored counts and emit repair candidates.

Clinic 011 names post 101, Ben user 2, and Ada user 1 so the learner can explain exactly which counter is stale and why.
