| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| javaconf | Primary kept candidate for heterogeneous source paths and node-type quotas. | Proof asserts it appears in graph candidates. | Trace names its graph path or score. | Drill removes its source path. |
| rejected row | Shows safety or graph exclusion before ranking. | Proof asserts exact rejected reason. | Trace names the exclusion reason. | Drill removes hard exclusion. |
| missed row | Shows graph retrieval can miss before ranking. | Proof asserts exact missed reason. | Trace names the graph failure. | Drill labels it low_score. |
| score/path row | Makes heterogeneous source paths and node-type quotas visible. | Proof checks semantic row fields. | Trace includes path or numeric value. | Drill erases row details. |
| Ada | Viewer whose graph neighborhood is traversed. | Proof uses Ada-derived outputs. | Trace starts from Ada paths where relevant. | Drill swaps viewer without recalculation. |
| source edge | Shows the traversal used by candidate generation. | Proof checks source-specific rows. | Trace names edge type or source path. | Drill treats all edges equally. |
| final pool | Handoff from graph retrieval to ranking. | Proof asserts exact ordered pool. | Trace includes kept candidates. | Drill returns expected IDs only. |
