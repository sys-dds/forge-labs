# Scenario

A profile card query should show post metrics and author totals. The broken query joins posts, likes, and comments directly, then counts the joined rows. Ada post A1 turns into six rows because its two likes combine with its three comments.

The fix is to choose the output grain first. For post metrics, the grain is one row per visible post. For author metrics, the grain is one row per author.

