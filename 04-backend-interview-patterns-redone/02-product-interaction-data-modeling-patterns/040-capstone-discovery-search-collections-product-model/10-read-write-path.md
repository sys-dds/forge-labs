# Read/Write Path

## Write path

- Create topic, hashtag, post, creator, listing, and follow rows.
- Record search session/query/filter/facet and saved-search rows.
- Store trend window, interaction events, signal components, snapshot, abuse, and treatment rows.
- Create collections, collection members, items, and saved items.

## Read path

- Derive topic discovery from follows and links.
- Apply search filter/facet contract to visible results.
- Use saved_searches state for alert contract.
- Sum trend components and suppress treated topics.
- Apply collection visibility and item lifecycle.

The verification query is the product read contract over those source rows.
