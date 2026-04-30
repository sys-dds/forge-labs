# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben proves comment and relationship value | Proof asserts 101 second in [501,101,601,901,701]. | Debug trace says components explain 101. | Drill remove comment weight. |
| 501 | Lina proves watch completion can lead ranking | Proof asserts 501 first. | Debug trace says multi-objective components explain 501. | Drill remove watch weight. |
| 601 | Maya proves share objective matters | Proof asserts 601 before 901 and 701. | Debug trace says components explain 601. | Drill remove share weight. |
| 701 | Omar proves hide/report risk penalty | Proof asserts 701 hide_penalty >= 0.8 and last. | Debug trace says components include 701 penalty. | Drill rank by like probability only. |
| 901 | New creator proves exploration bonus | Proof asserts 901 before 701. | Debug trace says components explain 901. | Drill remove exploration bonus. |
| weights | Readable weighted formula stands in for predictions | Proof asserts exact multi-objective final order. | Score rows expose every component. | Drill doubles hide penalty. |
