# Keyset Pagination Scroll

Ada scrolls a feed while a new post arrives. This pack shows why cursor pagination uses the last seen row instead of a page number.

The solution captures page one from the original timeline, inserts a newer post, then asks for the next page with a `(created_at, id)` cursor. The offset example repeats a row because the new post shifted the list.

Run:

```bash
./scripts/forge-test-practice.sh 01-sql/_practice/03-keyset-pagination-scroll
```

Expected views: `keyset_page_one`, `keyset_page_two`, `offset_page_two_after_insert`
