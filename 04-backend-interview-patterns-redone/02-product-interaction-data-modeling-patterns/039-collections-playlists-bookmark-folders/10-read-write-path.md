# Read/Write Path

## Write path

- Create private collection 3001 and public collection 3002.
- Add owner/member rows and ordered collection_items.
- Record duplicate_attempt item 5003.
- Write saved_items, deleted item state, block 7001, and treatment 8001.

## Read path

- Check collection visibility by owner/member/public.
- Filter active collection_items only.
- Order by item_position then item_id.
- Suppress deleted or blocked-author content.

The verification query is the product read contract over those source rows.
