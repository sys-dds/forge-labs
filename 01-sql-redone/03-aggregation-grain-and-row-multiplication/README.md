# Aggregation Grain And Row Multiplication

Backend scenario: profile cards and ranking inputs show inflated engagement because likes and comments are joined at the wrong grain.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/03-aggregation-grain-and-row-multiplication
```

## Rows To Inspect

- Ada post A1 has 2 likes and 3 comments; the raw join produces 6 rows.
- Ada post A2 has 1 like and 0 comments; it must not disappear.
- Ada post A3 is hidden and has 5 likes and 5 comments; none of it counts.
- Ben post B1 has 3 likes and 1 comment.
- Cy has no posts and still appears in the author summary with zero visible posts.

