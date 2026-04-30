# Read/Write Path

## Write path

- Create public channel 201 and private channel 202.
- Insert channel_memberships for Ben but not Cy.
- Insert posts 1001 through 1005 with pinned, deleted, and removed states.
- Insert community_threads row 6001 linking reply 1003 to parent post 1001.

## Read path

- Require active community_memberships for viewers.
- For private channels require channel_memberships.
- Filter deleted_at and remove/hide moderation actions.
- Join community_threads to prove reply parentage.

The verification query is intentionally a read contract over stored rows.
