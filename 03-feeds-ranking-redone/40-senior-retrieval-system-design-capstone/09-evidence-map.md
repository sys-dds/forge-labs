# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 followed backend item | followed source in final pool | Proof asserts 101 candidate source followed_author | Debug trace must mention 101 followed_author | Drill changes followed source |
| 201 lexical Java testing item | lexical retrieval in final pool | Proof asserts 201 lexical source | Debug trace must mention 201 lexical | Drill changes lexical source |
| 301 semantic backend item | semantic retrieval in final pool | Proof asserts 301 semantic source | Debug trace must mention 301 semantic | Drill changes semantic source |
| 401 two-tower high-similarity item | two-tower retrieval in final pool | Proof asserts 401 two_tower score | Debug trace must mention 401 two_tower | Drill changes two-tower source |
| 501 ANN approximate candidate | ANN retrieval in final pool | Proof asserts 501 ann source | Debug trace must mention 501 ann | Drill changes ANN source |
| 601 cold-start backfill item | cold-start retrieval in final pool | Proof asserts 601 cold_start_backfill | Debug trace must mention 601 cold_start_backfill | Drill changes cold-start |
| 701 blocked item | shared retrieval safety rejection | Proof asserts 701 blocked_author | Debug trace must mention 701 blocked_author | Drill changes safety |
| 801 unsafe item | shared retrieval safety rejection | Proof asserts 801 unsafe_content | Debug trace must mention 801 unsafe_content | Drill changes safety |
| 901 stale index miss | missing explanation for index freshness | Proof asserts 901 index_not_fresh | Debug trace must mention 901 index_not_fresh | Drill changes index freshness |
| 1001 ANN bucket miss | missing explanation for ANN probe | Proof asserts 1001 ann_bucket_not_probed | Debug trace must mention 1001 ann_bucket_not_probed | Drill changes ANN probe |
