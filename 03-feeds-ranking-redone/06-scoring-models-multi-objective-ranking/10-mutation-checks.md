# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Rank by like probability only | proof fails exact order [501,101,601,901,701] |
| Hide Omar 701 penalty | proof fails hide_penalty 0.8 assertion |
| Remove Lina completion component | proof fails 501 completion_score assertion |
| Remove Ben comment component | proof fails 101 comment_score assertion |
| Remove 901 exploration bonus | proof fails exploration_bonus assertion |
