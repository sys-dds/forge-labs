# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| Variant A | higher CTR but worse quality guardrails | winner assertion | trace includes Variant A | mutate Variant A rule |
| Variant B | lower CTR but better completion and guardrails | winner assertion | trace includes Variant B | mutate Variant B rule |
| clicks | CTR calculation proves primary metric | metric assertion | trace includes clicks | mutate clicks rule |
| completed | completion rate proves depth | metric assertion | trace includes completed | mutate completed rule |
| hides_reports | hide rate proves safety pressure | metric assertion | trace includes hides_reports | mutate hides_reports rule |
| distinct_authors | diversity proves author breadth | metric assertion | trace includes distinct_authors | mutate distinct_authors rule |
