# Keyset Pagination Stable Feeds

Backend scenario: Ada scrolls a feed while post 108 arrives between page one and page two. Offset pagination shifts under her; keyset pagination continues after the exact last row she saw.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/04-keyset-pagination-stable-feeds
```

## Rows To Inspect

- Post 107 and post 106 are page one before post 108 arrives.
- Post 108 arrives later at 10:06 and should not change Ada's page two after cursor 106.
- Post 105 and post 104 share timestamp 10:03 and must be ordered by id descending.
- Post 106 is the cursor row: continue after `(2026-01-01 10:04, 106)`.

