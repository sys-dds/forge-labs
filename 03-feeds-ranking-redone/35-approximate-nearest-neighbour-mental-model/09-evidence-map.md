# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 exact backend neighbour | closest exact and ANN candidate | Proof asserts 101 in exact and ANN | Debug trace must mention 101 probed backend | Drill changes probe bucket |
| 201 backend neighbour | ANN finds lower backend candidate | Proof asserts 201 in ANN | Debug trace must mention 201 probed backend | Drill changes ANN candidate |
| 301 sports item | distant item outside probed bucket | Proof excludes 301 | Debug trace must mention 301 bucket not probed | Drill changes bucket selection |
| 401 backend neighbour | ANN finds close backend candidate | Proof asserts 401 in ANN | Debug trace must mention 401 probed backend | Drill changes distance order |
| 501 stale_backend close item | exact finds it but ANN misses bucket | Proof asserts missed_by_ann 501 | Debug trace must mention 501 missed_by_ann stale_backend | Drill changes approx trade-off |
| 601 movies item | different bucket not probed | Proof excludes 601 | Debug trace must mention 601 bucket not probed | Drill changes probe bucket |
| 701 blocked backend item | eligibility still applies after probe | Proof asserts 701 blocked_author | Debug trace must mention 701 blocked_author | Drill changes eligibility |
