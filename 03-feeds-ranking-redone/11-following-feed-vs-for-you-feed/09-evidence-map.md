# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben proves followed recent content survives | Proof asserts 101 appears in both surfaces | Debug trace must explain item 101. | Drill changes item 101 behavior and reruns proof. |
| 102 | Ben older post proves chronological following still includes older followed content | Proof asserts 102 remains in both surfaces | Debug trace must explain item 102. | Drill changes item 102 behavior and reruns proof. |
| 201 | Cy proves muted followed content is rejected | Proof asserts 201 muted_author | Debug trace must explain item 201. | Drill changes item 201 behavior and reruns proof. |
| 301 | Noor proves blocked content is rejected | Proof asserts 301 blocked_author | Debug trace must explain item 301. | Drill changes item 301 behavior and reruns proof. |
| 401 | Diya proves another followed author survives | Proof asserts 401 in both outputs | Debug trace must explain item 401. | Drill changes item 401 behavior and reruns proof. |
| 501 | Lina proves For You can include out-of-network | Proof asserts 501 in For You and not Following | Debug trace must explain item 501. | Drill changes item 501 behavior and reruns proof. |
| 701 | Maya proves exploration in For You | Proof asserts 701 in For You | Debug trace must explain item 701. | Drill changes item 701 behavior and reruns proof. |
| 801 | Omar proves unsafe hard exclusion | Proof asserts 801 unsafe_content | Debug trace must explain item 801. | Drill changes item 801 behavior and reruns proof. |
