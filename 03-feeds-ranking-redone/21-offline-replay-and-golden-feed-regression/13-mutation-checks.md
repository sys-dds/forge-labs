# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Remove exploration reservation | expected replay final feed assertion |
| Allow blocked authors | expected 701 blocked_author rejection |
| Allow unsafe rows | expected 801 unsafe_content rejection |
| Skip golden comparison | expected empty regression_report assertion |
| Drop trace rows | expected debug_trace assertion |
