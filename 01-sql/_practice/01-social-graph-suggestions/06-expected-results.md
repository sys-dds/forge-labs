# Expected Results

`ada_second_degree_paths` shows why the final query needs exclusions:

| via_handle | candidate_handle | Meaning |
| --- | --- | --- |
| ben | ada | Ben follows Ada, so self-exclusion matters. |
| ben | diya | Diya is reachable through Ben. |
| cy | diya | Diya is also reachable through Cy, so `DISTINCT` matters. |
| cy | noor | Noor is reachable but blocked by Ada. |

`ada_safe_suggestions` must return exactly:

| suggested_handle |
| --- |
| diya |

Ben and Cy are already followed. Ada is the viewer. Noor is blocked. Theo is disconnected.
