# Data Model

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

## Constraints

- Collections have owner_user_id, visibility, and collection_type.
- Private collections require owner or active collection member visibility.
- Collection items have deterministic item_position and item_state.
- Duplicate attempts are represented and excluded from active item reads.
- Deleted and blocked-author items are suppressed.

## Trap rows

- Ada owns private collection 3001.
- Cy is not a member and cannot see private collection 3001.
- Public collection 3002 is visible to Cy.
- Collection item 5003 is duplicate_attempt and must not appear.
- Post 1002 is deleted and listing 2002 is authored by blocked Ben.
- Diya has active collection member row 4001 and can add item 5005.

## Why this shape

A bookmark folder is a product object with ownership, visibility, members, ordering, item lifecycle, and visibility checks. One bookmark boolean loses the contract.
