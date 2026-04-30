# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Allow unsafe 1001 | proof fails unsafe_content rejection |
| Allow Ben 103 and 104 into first page | proof fails Ben author cap assertion |
| Allow backend topic to fill first page | proof fails backend topic cap assertion |
| Remove 901 exploration reservation | proof fails exploration inclusion assertion |
| Remove diversity adjustment note for Ben | proof fails diversity_adjustments assertion |
| Remove trace for Maya 601 | proof fails debug_trace assertion for fresh movies insertion |
