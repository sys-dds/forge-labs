# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben proves relationship strength feature | Proof asserts 101 relationship_strength 10. | Debug trace says feature row explains Ben ranking. | Drill lowers relationship strength. |
| 501 | Lina proves completion feature can beat relationship | Proof asserts 501 completion_score 10. | Debug trace says video completion visible. | Drill removes completion feature. |
| 601 | Maya story keeps medium engagement row visible | Proof asserts 601 in final feed. | Debug trace names feature row for Maya. | Drill changes content type preference. |
| 701 | Omar has unsafe label and high negative feedback | Proof asserts 701 rejected as negative_feedback_risk. | Rejected trace explains safety/hide exclusion. | Drill rank by likes only and Omar wins. |
| 801 | Theo long video tests network suitability penalty | Proof asserts 801 network_suitability <= 2. | Debug trace says feature row explains penalty. | Drill remove network feature. |
| 901 | New creator proves exploration row stays inspectable | Proof asserts 901 exists in feature_rows. | Debug trace names exploration feature row. | Drill drop low-history creators. |
