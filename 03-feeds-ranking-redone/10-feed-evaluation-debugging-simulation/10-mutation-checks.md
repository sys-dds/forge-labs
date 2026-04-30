# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Allow Noor 701 into final_feed | proof fails blocked_author and final output assertions |
| Allow Ben 102 into final_feed | proof fails author_repetition rejection |
| Allow Ben 103 into final_feed | proof fails author_repetition rejection |
| Omit exploration 901 | proof fails exploration inclusion and offline replay assertions |
| Remove score components | proof fails score_components assertion |
| Remove diversity adjustments | proof fails diversity_adjustments assertion |
| Remove explanation for Lina 501 | proof fails debug_trace assertion for final item 501 |
