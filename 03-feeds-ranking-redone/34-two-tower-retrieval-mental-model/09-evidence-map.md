# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| Ada backend feeds user | proves user tower changes candidates | Proof asserts Ada embedding and candidates | Debug trace must mention ada pair score | Drill changes user tower |
| Ben movies user | proves different user gets different pool | Proof asserts Ben movie candidate only | Debug trace must mention ben pair score | Drill changes user tower |
| 101 backend feed post | Ada backend candidate | Proof asserts 101 in Ada pool | Debug trace must mention 101 scored for ada | Drill changes item tower |
| 201 movie recommendation post | Ben movie candidate | Proof asserts 201 in Ben pool | Debug trace must mention 201 scored for ben | Drill changes item tower |
| 301 feed ranking post | highest Ada feed candidate | Proof asserts 301 first for Ada | Debug trace must mention 301 scored for ada | Drill changes pair scoring |
| 401 cooking post | low similarity miss | Proof asserts 401 missed low_similarity | Debug trace must mention 401 low_similarity | Drill changes threshold |
| 501 backend testing post | Ada backend support candidate | Proof asserts 501 in Ada pool | Debug trace must mention 501 scored for ada | Drill changes top-k |
| 601 blocked backend post | blocked retrieval eligibility | Proof asserts 601 blocked_author | Debug trace must mention 601 blocked_author | Drill changes eligibility |
