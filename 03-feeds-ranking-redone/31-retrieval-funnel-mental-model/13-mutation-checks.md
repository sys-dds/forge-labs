# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Remove cold-start exploration 901 | final_candidate_pool assertion |
| Skip muted eligibility | 201 rejection assertion |
| Drop source labels | candidate source assertion |
| Mark 701 as low score | missed reason assertion |
| Delete retrieval_debug_trace | trace assertion |
