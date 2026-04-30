# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Return expected["final_feed"] directly | quality gate fails shortcut audit and proof still requires traces/rejections |
| Remove a debug trace | proof fails debug_trace assertion |
| Allow a rejected item | proof fails rejected_items assertion |
| Remove the dominant ranking signal | proof fails exact output assertion |
| Drop candidate source or score rows | proof fails source/feature/score assertion |
