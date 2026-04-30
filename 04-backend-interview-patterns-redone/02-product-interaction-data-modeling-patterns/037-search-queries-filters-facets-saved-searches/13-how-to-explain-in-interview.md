# How To Explain In Interview

## Direct answer

Record query/session rows, model filters and facets explicitly, persist saved searches with state, and derive results from visible posts/listings/creators after filters and safety suppression.

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

## Actual trap rows

- Query 1001 records Ada searching workshop.
- Filter 2001 restricts result_type to post.
- Facet 3001 expects visible post count for topic 501.
- Saved search 4002 is paused and must not alert.
- Listing 6001 is hidden by treatment 8001 and creator 701 is blocked by block 9001.

## Exact query mechanics

The query builds query_filters, visible_results, filtered_results, facet_counts, and alertable_saved_searches before emitting query_recorded, filter_applied, facet_count, and search_debug_trace.

## Write path

Record session 1101 and query 1001. Store filter 2001 and facet row 3001. Store active saved search 4001 and paused saved search 4002. Write hidden treatment 8001 and block 9001.

## Discovery/product follow-up

The product can answer why a result was shown, why a saved search did not alert, and how facet counts were derived.

## Scaling follow-up

Later read models can cache facets, but the contract should still match these source rows.
