# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | Ben close-friend story is valid tray item | Proof asserts story_tray [101]. | Debug trace says unexpired close-friend story. | Drill mark Ben story expired. |
| 102 | Ben expired story tests TTL | Proof asserts 102 rejected as expired_story. | Rejected trace records expiry. | Drill ignore expiry. |
| 201 | Cy muted friend story tests mute filtering | Proof asserts 201 rejected as muted_author. | Rejected trace records mute. | Drill remove mute check. |
| 301 | Noor blocked story tests block filtering | Proof asserts 301 rejected as blocked_author. | Rejected trace records block. | Drill remove block check. |
| 501 | Lina Spotlight video is eligible UK English item | Proof asserts spotlight_feed includes 501 second. | Debug trace says UK English match. | Drill change Lina language. |
| 601 | Omar wrong-language video tests eligibility | Proof asserts 601 rejected as language_mismatch. | Rejected trace records language mismatch. | Drill ignore language. |
| 701 | Maya proves completion beats raw likes | Proof asserts spotlight_feed [701,501]. | Debug trace says completion ranking. | Drill rank by likes only. |
| 801 | Theo reported video tests integrity filter | Proof asserts 801 rejected as reported_content. | Rejected trace records report risk. | Drill ignore reports. |
