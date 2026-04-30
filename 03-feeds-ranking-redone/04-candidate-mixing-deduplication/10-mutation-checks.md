# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Concatenate pools directly | proof fails no duplicate content IDs |
| Lose Lina 501 trending reason | proof fails all_reasons assertion for 501 |
| Set Lina 501 primary source to trending | proof fails primary reason social_proof assertion |
| Allow two in_network items on page | proof fails exact mixed page output |
| Remove reason-preservation trace for 501 | proof fails debug_trace assertion mentioning preserved reasons |
