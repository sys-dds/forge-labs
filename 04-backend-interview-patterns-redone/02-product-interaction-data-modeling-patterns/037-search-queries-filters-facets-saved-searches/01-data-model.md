# Data Model

## Actual tables

- `users`
- `search_queries`
- `search_sessions`
- `search_filters`
- `search_facets`
- `saved_searches`
- `posts`
- `listings`
- `creators`
- `content_treatments`
- `block_edges`

## Constraints

- Queries and sessions are recorded separately.
- Filters constrain results before facets are counted.
- Saved searches store query and filter state, and paused searches do not alert.
- Deleted, hidden, and blocked-author results are suppressed.

## Trap rows

- Query 1001 records Ada searching workshop.
- Filter 2001 restricts result_type to post.
- Facet 3001 expects visible post count for topic 501.
- Saved search 4002 is paused and must not alert.
- Listing 6001 is hidden by treatment 8001 and creator 701 is blocked by block 9001.

## Why this shape

Search product contracts are more than text. The read must combine recorded query intent, filters, facets, saved state, and safety visibility.
