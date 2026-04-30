# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Return expected["final_feed"] directly | quality gate fails shortcut audit and proof still requires traces/rejections |
| Remove a final item debug trace | proof fails debug_trace assertion |
| Allow a rejected item into the output | proof fails rejected_items and exact output assertions |
| Remove the main score or ordering signal | proof fails exact final output assertion |
| Drop a candidate source label | proof fails source/reason assertion |
