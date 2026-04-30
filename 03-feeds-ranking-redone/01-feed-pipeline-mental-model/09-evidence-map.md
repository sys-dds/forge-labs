# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben followed author survives eligibility | Proof asserts final feed [101,501,401,701] and eligible IDs include 101. | Debug trace says Ben is followed, safe, visible, high affinity. | Drill changes Ben affinity and reruns final order. |
| 201 | Cy is muted but has high engagement | Proof asserts 201 rejected with reason muted_author. | Rejected trace explains mute before scoring. | Drill removes mute filter to watch Cy leak. |
| 301 | Noor is blocked and tempting by engagement | Proof asserts 301 rejected with reason blocked_author. | Rejected trace explains block before scoring. | Drill moves block after ranking to reproduce bad leak. |
| 401 | Diya proves group inventory can survive | Proof asserts 401 appears after Lina. | Debug trace says Diya comes from Ada group. | Drill changes group source weight. |
| 501 | Lina proves out-of-network similar topic can mix in | Proof asserts 501 ranks second. | Debug trace names backend topic match. | Drill lowers similar-topic score. |
| 601 | Omar is unsafe with highest engagement | Proof asserts 601 rejected with reason unsafe_content. | Rejected trace says unsafe content removed before scoring. | Drill scores before eligibility and sees Omar first. |
| 701 | Maya proves exploration survives low engagement | Proof asserts 701 appears fourth. | Debug trace says exploration fills after exclusions. | Drill removes exploration and proof fails. |
