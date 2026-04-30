# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 701 | Noor blocked item is the reported bug | Proof asserts 701 rejected as blocked_author. | Rejected trace answers why Ada did not see 701. | Drill remove eligibility and replay broken output. |
| 101 | Ben valid in-network item should remain | Proof asserts final feed starts 101. | Debug trace answers why Ada saw 101. | Drill lower relationship score. |
| 102 | Ben repeated item tests diversity reduction | Proof asserts 102 rejected as author_repetition. | Rejected trace answers why Ada did not see 102. | Drill remove author repetition rule. |
| 103 | Second repeated Ben item proves cap is not accidental | Proof asserts 103 rejected as author_repetition. | Rejected trace answers why Ada did not see 103. | Drill allow three Ben posts. |
| 501 | Lina similar topic replaces repeated Ben | Proof asserts 501 second. | Debug trace answers why Ada saw Lina. | Drill remove similar-topic source. |
| 601 | Maya group content adds diversity | Proof asserts 601 third. | Debug trace answers why Ada saw Maya. | Drill remove group source. |
| 901 | New creator fixes missing exploration bug | Proof asserts 901 included and offline replay matches. | Debug trace answers why Ada saw exploration. | Drill remove exploration insertion. |
