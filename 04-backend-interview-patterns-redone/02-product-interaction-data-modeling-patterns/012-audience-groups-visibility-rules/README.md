# 012 Audience Groups Visibility Rules

Design audience visibility for public posts, private posts, friends-only posts, close-friends posts, and blocked viewers.

Schema `bip_pim_012` uses concrete trap rows: viewer Ada 1 sees public post 201, cannot see Ben private post 202, sees own private post 203, sees Cy friends-only post 204, sees Diya close-friends post 205 only while group member 1 exists, cannot see Eli close-friends post 206, cannot see Omar blocked post 207, and cannot see deleted post 208.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/012-audience-groups-visibility-rules`.
