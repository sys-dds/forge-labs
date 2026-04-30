# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Return low_score for every miss | no-low-score assertion |
| Omit exploration fallback | final pool assertion |
| Drop retrieval stage | stage assertion |
| Confuse index freshness | 301 assertion |
| Delete miss traces | trace assertion |
