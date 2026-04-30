# SQL Mastery Gauntlet

Gauntlet mode is the repair bench after chapter and practice mode. Each pack loads a realistic broken query, proves that it fails against named data, then loads the corrected solution and proves the fix.

Use it when you can already read the chapter solution and want to practice debugging under pressure:

```bash
./scripts/forge-list-gauntlet.sh
./scripts/forge-inspect-gauntlet.sh 01-sql/_gauntlet/01-feed-candidate-query-clinic
./scripts/forge-load-gauntlet.sh 01-sql/_gauntlet/01-feed-candidate-query-clinic
./scripts/forge-test-gauntlet.sh 01-sql/_gauntlet/01-feed-candidate-query-clinic
./scripts/forge-test-all-gauntlets.sh
```

The proof script is the judge. A good repair should make the broken behavior impossible, not merely return a plausible row.
