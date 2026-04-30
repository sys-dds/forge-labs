# Discovery, Search, Topics, Collections Patterns

Clinics 036-040 keep discovery modeling at the product data-contract level. The goal is not to build a search engine. The goal is to explain why a row appears or disappears from a discovery surface using source tables.

Useful interview checks:

- `hashtags` should normalize into `topics`; raw text alone cannot explain topic follows or creator-topic links.
- `user_topic_follows`, `content_topic_links`, and `creator_topic_links` should drive topic discovery contracts.
- `search_queries`, `search_sessions`, `search_filters`, `search_facets`, and `saved_searches` should explain query intent, filtered results, facet counts, and alert eligibility.
- `trend_windows`, `trend_signal_components`, `trend_snapshots`, `abuse_signal_events`, and `policy_treatments` should explain velocity, unique actors, freshness, suppression, and trend debug traces.
- `collections`, `collection_members`, `collection_items`, and `saved_items` should keep ownership, visibility, collaboration, ordering, duplicate attempts, and saved-item lifecycle separate.

Concrete trap rows include hashtag 301 in clinic 036, filter 2001 and paused saved search 4002 in clinic 037, treatment 7001 in clinic 038, collection item 5003 in clinic 039, and capstone treatment 16001 plus duplicate item 13003 in clinic 040.
