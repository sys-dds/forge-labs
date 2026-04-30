# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 1001 | Unsafe item tests eligibility before diversity | Proof asserts 1001 rejected as unsafe_content. | Rejected trace records unsafe eligibility. | Drill allow high unsafe score. |
| 101 | Ben top relevant item should stay | Proof asserts 101 first. | Debug trace says top relevant Ben preserved. | Drill lower Ben score. |
| 102 | Ben second item is still within author cap | Proof asserts 102 second and Ben count <= 2. | Debug trace says second Ben allowed. | Drill max author cap to one. |
| 103 | Ben third item proves author cap | Proof asserts 103 rejected as author_cap_ben. | Rejected trace names author cap. | Drill remove author cap. |
| 501 | Lina backend item proves topic cap | Proof asserts 501 rejected as topic_cap_backend. | Rejected trace names backend topic cap. | Drill remove topic cap. |
| 601 | Maya fresh movies item satisfies freshness and topic variety | Proof asserts 601 in final feed. | Debug trace names fresh movies insertion. | Drill remove fresh requirement. |
| 701 | Diya cooking item adds topic diversity | Proof asserts 701 in final feed. | Debug trace names cooking diversity. | Drill skip non-backend filler. |
| 901 | New creator satisfies exploration rule | Proof asserts 901 included. | Debug trace names exploration rule. | Drill remove exploration requirement. |
