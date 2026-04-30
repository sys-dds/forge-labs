# Recursive Comment Threads

Backend scenario: Ada opens the comment subtree rooted at c1 on post 100. The backend must return only that subtree, with stable order and depth.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/08-recursive-comment-threads
```

## Rows To Inspect

- c1 is the requested root on post 100.
- c2 and c3 are direct replies to c1.
- c4 replies to c2, and c5 replies to c4.
- c8 is a second root on post 100 and must not appear when the subtree starts at c1.
- c6 and c7 belong to post 200 and must not leak into post 100's thread.

