# Data Model

## Actual tables

- `users`
- `topics`
- `hashtags`
- `posts`
- `creators`
- `listings`
- `content_topic_links`
- `creator_topic_links`
- `user_topic_follows`
- `search_queries`
- `search_sessions`
- `search_filters`
- `search_facets`
- `saved_searches`
- `interaction_events`
- `trend_windows`
- `trend_signal_components`
- `trend_snapshots`
- `collections`
- `collection_members`
- `collection_items`
- `saved_items`
- `block_edges`
- `policy_treatments`
- `abuse_signal_events`

## Constraints

- Topic discovery depends on topic follows and content/creator links.
- Search results apply filters and visible content rules before facets.
- Saved searches store state and only active searches alert.
- Trending derives from component rows and treatment suppression.
- Collections require owner/member/public visibility and active item lifecycle.

## Trap rows

- Ada user 1 follows topic 101 through follow 5001.
- Hashtag 301 maps #workshop to topic 101.
- Query 9001 has filter 9101 result_type post.
- Saved search 9202 is paused.
- Topic 102 is suppressed by abuse signal 15001 and treatment 16001.
- Private collection 12001 is visible to Ada but not Cy.
- Collection item 13003 is duplicate_attempt and must be excluded.

## Why this shape

The capstone composes discovery primitives without building a full search or ranking system. Each result has a row-level why-shown or why-hidden explanation.
