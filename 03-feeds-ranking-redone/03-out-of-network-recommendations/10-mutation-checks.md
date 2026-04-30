# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Use only regional trending retrieval | proof fails final feed [501,601,701,901] |
| Allow Noor 801 through safety checks | proof fails blocked_or_unsafe rejection |
| Keep Lina 502 with Lina 501 | proof fails max one Lina item and author_cap_lina rejection |
| Drop Theo 901 fallback | proof fails exploration_fallback reason and final output |
| Remove Ada OLED interest path for Maya 601 | proof fails reason assertion for 601 similar_interest_oled |
