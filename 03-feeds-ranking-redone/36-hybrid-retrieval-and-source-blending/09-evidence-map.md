# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 followed backend post | followed source anchor | Proof asserts 101 followed_author | Debug trace must mention 101 followed_author | Drill changes followed source |
| 201 lexical Java testing post | lexical source candidate | Proof asserts 201 lexical | Debug trace must mention 201 lexical | Drill changes lexical source |
| 301 semantic testing post | semantic source candidate | Proof asserts 301 semantic | Debug trace must mention 301 semantic | Drill changes semantic source |
| 401 trending unrelated post | quota/relevance rejection | Proof asserts 401 low_relevance_trending | Debug trace must mention 401 low_relevance_trending | Drill changes trending quota |
| 501 exploration new creator | exploration source preserved | Proof asserts 501 exploration | Debug trace must mention 501 exploration | Drill changes exploration source |
| 601 lexical plus semantic | multi-source reason preservation | Proof asserts both reasons | Debug trace must mention 601 lexical + semantic | Drill changes source merge |
| 701 blocked trending post | blocked rejection | Proof asserts 701 blocked_author | Debug trace must mention 701 blocked_author | Drill changes eligibility |
| 801 unsafe high-trending post | unsafe rejection | Proof asserts 801 unsafe_content | Debug trace must mention 801 unsafe_content | Drill changes safety |
