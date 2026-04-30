# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben in-network post anchors followed-author replay | final feed assertion keeps 101 | debug trace names 101 | drill changes 101 rule |
| 501 | Lina similar-topic post checks topic retrieval | final feed assertion keeps 501 | debug trace names 501 | drill changes 501 rule |
| 601 | Maya group post checks group candidate source | final feed assertion keeps 601 | debug trace names 601 | drill changes 601 rule |
| 701 | Noor blocked post checks hard block rejection | assert_rejected catches blocked_author | debug trace names 701 | drill changes 701 rule |
| 801 | Omar unsafe post checks integrity rejection | assert_rejected catches unsafe_content | debug trace names 801 | drill changes 801 rule |
| 901 | Theo exploration post checks reserved exploration | final feed and trace keep 901 | debug trace names 901 | drill changes 901 rule |
