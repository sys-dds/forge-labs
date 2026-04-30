# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 popular backend post | popular engagement candidate | Proof asserts 101 retrieved | Debug trace must mention 101 engagement retrieval | Drill changes engagement source |
| 201 popular movie post | second popular candidate | Proof asserts 201 retrieved | Debug trace must mention 201 engagement retrieval | Drill changes engagement source |
| 301 new backend creator | cold-start backfill no likes | Proof asserts 301 backfill reason | Debug trace must mention 301 no-engagement cold-start | Drill changes cold-start source |
| 401 cooking creator | low interest rejection | Proof asserts 401 low_user_interest_match | Debug trace must mention 401 low_user_interest_match | Drill changes interest score |
| 501 unsafe new creator | safety filter for cold-start | Proof asserts 501 unsafe_new_creator | Debug trace must mention 501 unsafe_new_creator | Drill changes safety |
| 601 profile-topic new creator | cold-start profile match | Proof asserts 601 backfill reason | Debug trace must mention 601 profile-topic cold-start | Drill changes profile match |
| 701 old popular unrelated | popular but unrelated rejection | Proof asserts 701 unrelated_popular_item | Debug trace must mention 701 unrelated_popular_item | Drill changes popular filter |
