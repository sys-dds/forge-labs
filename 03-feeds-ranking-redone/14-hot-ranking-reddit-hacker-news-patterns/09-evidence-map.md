# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben fresh high votes | Proof asserts 101 near top | Debug trace must explain 101. | Drill mutates 101 and reruns proof. |
| 201 | Cy old high votes | Proof asserts 201 last | Debug trace must explain 201. | Drill mutates 201 and reruns proof. |
| 301 | Noor removed post | Proof asserts removed_by_moderation | Debug trace must explain 301. | Drill mutates 301 and reruns proof. |
| 401 | Diya very fresh post | Proof asserts 401 first | Debug trace must explain 401. | Drill mutates 401 and reruns proof. |
| 501 | Lina comments add heat | Proof asserts 501 before 701 | Debug trace must explain 501. | Drill mutates 501 and reruns proof. |
| 601 | Omar controversy penalty | Proof asserts 601 before old Cy only | Debug trace must explain 601. | Drill mutates 601 and reruns proof. |
| 701 | Maya fresh low votes | Proof asserts 701 above old Cy | Debug trace must explain 701. | Drill mutates 701 and reruns proof. |
