# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 501 | Lina backend post matches Ada backend interest | Proof asserts 501 reason similar_topic_backend. | Debug trace names backend after in-network exhaustion. | Drill lets Lina 502 also through to test author cap. |
| 502 | Lina Java item tests max one per author | Proof asserts 502 rejected as author_cap_lina. | Rejected trace names author cap at mixing. | Drill disables author cap. |
| 601 | Maya OLED movie post matches Ada interest | Proof asserts 601 in final feed. | Debug trace names OLED movie interest. | Drill removes OLED interest. |
| 701 | Omar proves regional trending can survive eligibility | Proof asserts 701 in final feed. | Debug trace names regional trending. | Drill lowers trending quota. |
| 801 | Noor is blocked and unsafe despite high score | Proof asserts 801 rejected as blocked_or_unsafe. | Rejected trace records safety eligibility. | Drill retrieves only trending and sees Noor. |
| 901 | Theo proves exploration fallback inclusion | Proof asserts 901 reason exploration_fallback. | Debug trace says cold-start exploration. | Drill removes fallback source. |
| 1001 | Cy represents repeated low-quality creator | Proof asserts 1001 rejected as low_quality_repeat_creator. | Rejected trace records quality exclusion. | Drill disables creator quality filter. |
