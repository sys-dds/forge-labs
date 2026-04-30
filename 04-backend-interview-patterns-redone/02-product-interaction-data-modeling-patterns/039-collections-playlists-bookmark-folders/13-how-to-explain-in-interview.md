# How To Explain In Interview

## Direct answer

Use collections for the folder/playlist object, collection_members for collaboration, collection_items for ordered lifecycle rows, saved_items for user saves, and visibility/treatment/block rows for read suppression.

## Actual tables

- `users`
- `posts`
- `listings`
- `collections`
- `collection_members`
- `collection_items`
- `saved_items`
- `block_edges`
- `content_treatments`

## Actual trap rows

- Ada owns private collection 3001.
- Cy is not a member and cannot see private collection 3001.
- Public collection 3002 is visible to Cy.
- Collection item 5003 is duplicate_attempt and must not appear.
- Post 1002 is deleted and listing 2002 is authored by blocked Ben.
- Diya has active collection member row 4001 and can add item 5005.

## Exact query mechanics

The query builds visible_collections, visible_items, duplicate_attempts, and collaborator_permissions before emitting collection_item_order and collaborative_member_add_allowed.

## Write path

Create private collection 3001 and public collection 3002. Add owner/member rows and ordered collection_items. Record duplicate_attempt item 5003. Write saved_items, deleted item state, block 7001, and treatment 8001.

## Discovery/product follow-up

The product can explain who can see a collection, who can add to it, and why a saved item is hidden.

## Scaling follow-up

At larger size, cache collection previews, but preserve collection_items as ordered source rows.
