# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben close friend creates strongest social graph path | Proof asserts candidate row 101 source close_friend. | Debug trace says Ben is close friend candidate. | Drill downgrades Ben to followed only. |
| 201 | Cy followed author is muted | Proof asserts 201 rejected as muted_author. | Rejected trace records mute eligibility failure. | Drill removes mute check and Cy leaks. |
| 301 | Noor followed author is blocked | Proof asserts 301 rejected as blocked_author. | Rejected trace records blocked eligibility failure. | Drill removes block check. |
| 401 | Diya proves shared group candidates are in network | Proof asserts candidate row 401 source shared_group. | Debug trace names Ada shared group. | Drill removes group retrieval. |
| 501 | Lina proves comment-social-proof path | Proof asserts candidate row 501 source commented_by_following. | Debug trace says Maya comment created social proof. | Drill duplicates Lina through another source. |
| 601 | Theo public post has no social path | Proof asserts 601 rejected as no_social_path. | Rejected trace records candidate-generation exclusion. | Drill treats all public posts as in-network. |
