# How To Explain In Interview

## Direct answer

Compose normalized topic discovery, filtered search, saved searches, explainable trend components, safety suppression, and collection visibility from explicit tables and lifecycle rows.

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

## Actual trap rows

- Ada user 1 follows topic 101 through follow 5001.
- Hashtag 301 maps #workshop to topic 101.
- Query 9001 has filter 9101 result_type post.
- Saved search 9202 is paused.
- Topic 102 is suppressed by abuse signal 15001 and treatment 16001.
- Private collection 12001 is visible to Ada but not Cy.
- Collection item 13003 is duplicate_attempt and must be excluded.

## Exact query mechanics

The query builds topic_surface, search_results, facet_counts, alertable_saved_searches, trend_totals, suppressed_topics, visible_collections, visible_collection_items, and a combined debug trace.

## Write path

Create topic, hashtag, post, creator, listing, and follow rows. Record search session/query/filter/facet and saved-search rows. Store trend window, interaction events, signal components, snapshot, abuse, and treatment rows. Create collections, collection members, items, and saved items.

## Discovery/product follow-up

The product can explain discovery rows: followed topic, applied search filter, facet count, saved-search state, trend components, treatment, and collection item lifecycle.

## Scaling follow-up

The next step is read-model materialization, not a platform rewrite. The source-table contract remains the interview answer.
