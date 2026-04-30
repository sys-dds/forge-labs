# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben is primary in-network slot | Proof asserts final order starts with 101. | Debug trace says in_network primary reason. | Drill consumes in-network quota with 102 first. |
| 102 | Ben second in-network item tests source quota | Proof asserts 102 not in final page. | Candidate reasons show 101 consumed in_network slot. | Drill raises in_network quota. |
| 501 | Lina enters from three pools and must dedupe | Proof asserts 501 reasons social_proof, similar_topic, trending. | Debug trace lists all preserved reasons. | Drill concatenates pools and repeats 501. |
| 502 | Lina weaker social proof item tests quota | Proof asserts 502 not in final feed. | Mixing trace shows 501 used social_proof slot. | Drill lets social_proof dominate. |
| 601 | Maya fills similar topic after 501 dedupe | Proof asserts 601 third in final feed. | Debug trace names similar_topic primary reason. | Drill removes dedupe and 601 disappears. |
| 701 | Omar fills trending without duplicating 501 | Proof asserts 701 fourth. | Debug trace names trending slot. | Drill lets trending pool dominate. |
| 901 | Theo fills exploration quota | Proof asserts 901 fifth. | Debug trace names exploration slot. | Drill removes exploration quota. |
