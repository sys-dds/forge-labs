# Matching Candidate Filtering

Ada opens matching candidates. This pack separates three backend questions:

1. Which pairs are mutual matches?
2. Which profiles are raw candidates after safety and action exclusions?
3. Which raw candidates fit Ada's preferences?

Run:

```bash
./scripts/forge-test-practice.sh 01-sql/_practice/04-matching-candidate-filtering
```

Expected views: `ada_mutual_matches`, `ada_raw_candidates`, `ada_preference_fit_candidates`
