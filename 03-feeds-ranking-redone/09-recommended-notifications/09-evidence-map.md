# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| ben_posted | Ben close-friend update should send | Proof asserts sent notifications include ben_posted. | Debug trace says high open probability and no quiet hours. | Drill lower open probability. |
| ben_posted_duplicate | Duplicate Ben event tests dedupe | Proof asserts rejected as duplicate_notification. | Rejected trace records source_event_id dedupe. | Drill disable dedupe. |
| lina_similar_topic | Lina candidate tests quiet hours | Proof asserts rejected as quiet_hours. | Rejected trace records quiet-hours gate. | Drill ignore quiet hours. |
| maya_thread | Maya active thread should send | Proof asserts sent notifications include maya_thread. | Debug trace says active thread within fatigue limit. | Drill reduce urgency. |
| omar_trending | Omar trending tests fatigue/open probability | Proof asserts rejected as fatigue_or_low_open_probability. | Rejected trace records ranking/fatigue decision. | Drill raise fatigue limit. |
| noor_blocked | Noor blocked notification tests safety controls | Proof asserts rejected as blocked_author. | Rejected trace records blocked author. | Drill remove block filter. |
