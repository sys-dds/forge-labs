# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 | followed item proves shortlist path | final feed assertion | trace includes 101 | mutate 101 rule |
| 401 | fresh diverse item proves reranker | final feed assertion | trace includes 401 | mutate 401 rule |
| 501 | topic item proves heavy ranker | final feed assertion | trace includes 501 | mutate 501 rule |
| 801 | exploration item proves mix slot | final feed assertion | trace includes 801 | mutate 801 rule |
| 301 | unsafe item proves prefilter | rejection assertion | trace includes 301 | mutate 301 rule |
| latency | 100ms budget proves staged work | latency assertion | trace includes latency | mutate latency rule |
| shortlist | shortlist proves not every candidate heavy-ranked | heavy-ranked assertion | trace includes shortlist | mutate shortlist rule |
