# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| control | baseline metrics anchor deltas | delta assertion | trace includes control | mutate control rule |
| treatment | higher CTR but harmful guardrails | launch assertion | trace includes treatment | mutate treatment rule |
| hide_report_rate | safety guardrail | failure assertion | trace includes hide_report_rate | mutate hide_report_rate rule |
| creator_diversity | diversity guardrail | failure assertion | trace includes creator_diversity | mutate creator_diversity rule |
| retention | retention guardrail | failure assertion | trace includes retention | mutate retention rule |
| dwell | quality metric context | debug trace | trace includes dwell | mutate dwell rule |
