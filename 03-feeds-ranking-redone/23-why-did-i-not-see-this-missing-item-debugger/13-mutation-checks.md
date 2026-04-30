# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Call every miss low_score | missing explanation assertion |
| Disable seen-state check | 701 already_seen assertion |
| Disable freshness check | 801 stale assertion |
| Disable diversity cap | 501 diversity assertion |
| Drop trace rows | debug_trace assertion |
