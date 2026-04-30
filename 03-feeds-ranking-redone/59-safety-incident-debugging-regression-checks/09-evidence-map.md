| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| primary safe output | Shows the corrected safety-aware handoff. | Proof asserts exact safe/final feed or decision list. | Trace explains kept treatment. | Drill returns expected IDs only. |
| rejected item | Shows hard removal before ranking. | Proof asserts exact rejection reason and stage. | Trace names policy reason. | Drill converts remove to reduce. |
| downranked item | Shows reduce distribution treatment. | Proof asserts downranked row. | Trace names penalty or treatment. | Drill removes penalty. |
| informed or reviewed item | Shows label/review is distinct from remove. | Proof asserts informed or review row. | Trace names context/review reason. | Drill drops queue or label. |
| evidence row | Keeps the decision auditable. | Proof checks evidence/trust/risk/audit fields. | Trace mentions evidence. | Drill erases evidence. |
| policy decision | Maps label to treatment. | Proof asserts treatment semantics. | Trace names treatment. | Drill treats every issue as score-only. |
| audit trail | Lets later reviews explain the decision. | Proof checks audit or trace lineage. | Trace includes actual IDs. | Drill overwrites original decision. |
