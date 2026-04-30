# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Allow expired Ben 102 story | proof fails expired_story rejection and story tray exact assertion |
| Allow muted Cy 201 story | proof fails muted_author rejection |
| Allow blocked Noor 301 story | proof fails blocked_author rejection |
| Rank Spotlight by likes | proof fails spotlight [701,501] and completion assertion |
| Allow wrong-language Omar 601 | proof fails language_mismatch rejection |
| Allow reported Theo 801 | proof fails reported_content rejection |
