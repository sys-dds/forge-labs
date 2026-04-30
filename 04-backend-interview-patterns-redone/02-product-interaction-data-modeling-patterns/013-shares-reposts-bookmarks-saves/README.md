# 013 Shares Reposts Bookmarks Saves

Model shares, reposts, quote reposts, bookmarks, and saves without duplicating content or leaking hidden originals.

Schema `bip_pim_013` uses concrete trap rows: repost 301 points to Ben original post 201, quote repost 401 has Ada text plus original 201, Ada bookmark history rows 501 and 502 should count once, Cy cannot see Ada private save, deleted original 202 suppresses repost 302, and Omar original 203 is blocked for Ada so repost 303 is suppressed.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/013-shares-reposts-bookmarks-saves`.
