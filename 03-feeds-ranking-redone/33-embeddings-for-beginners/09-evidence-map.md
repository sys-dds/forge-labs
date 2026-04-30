# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| Ada user vector [backend, movies, cooking] | anchors vector query | Proof asserts similarity rows use Ada vector | Debug trace must mention Ada dimensions backend movies cooking | Drill changes query vector |
| 101 backend tutorial | highest backend similarity | Proof asserts 101 dot and cosine | Debug trace must mention 101 backend dimension | Drill changes dot product |
| 201 movie ranking video | secondary movie interest candidate | Proof asserts 201 appears after mixed items | Debug trace must mention 201 movie dimension | Drill changes candidate order |
| 301 cooking post | low similarity miss | Proof asserts 301 below threshold miss | Debug trace must mention 301 below semantic threshold | Drill changes threshold |
| 401 backend movie architecture | mixed backend/movie similarity | Proof asserts 401 similarity row | Debug trace must mention 401 backend movie dimensions | Drill changes cosine calculation |
| 501 blocked backend post | eligibility beats high similarity | Proof asserts 501 blocked_author | Debug trace must mention 501 blocked_author | Drill changes block eligibility |
| 601 exploration mixed vector | mixed-interest candidate | Proof asserts 601 similarity row | Debug trace must mention 601 mixed vector | Drill changes top-k cutoff |
