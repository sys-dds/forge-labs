# Modeling Constraints Relationships

Backend scenario: a service marketplace stores buyers, sellers, listings, follows, blocks, and saved listings. The clinic proves that constraints are executable product rules, not decoration around storage.

Read the files in order, then run:

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/01-modeling-constraints-relationships
```

## Rows To Inspect

- Ada has buyer profile 1001, follows Ben, blocks Cy, and saves Ben listing 101.
- Ben has seller profile 1002 and owns listings 101 and 102.
- Cy has seller profile 1003 and owns listing 201, which Ada blocks through the owner relationship.
- Diya saves Ben listing 101 too; that proves saved listings are per user/listing pair, not per listing globally.
- Noor has no follows, blocks, listings, or saves; that proves users can exist before relationships arrive.

