# Graph Debugging Playbook

## edge freshness
Plain-English meaning: how old a graph relationship is.
Tiny example from clinics 41-50: an old Ben follow decays below a fresh Diya reply in clinic 48.
Common beginner mistake: treating a 200-day follow like yesterday's reply.
How to debug it: log edge age, base weight, decay, and final strength.
What a senior engineer asks next: when should an edge expire?

## edge decay
Plain-English meaning: reducing an edge's strength as it ages.
Tiny example from clinics 41-50: Ben's old follow has strength 0.1 after decay.
Common beginner mistake: applying decay to block edges instead of hard excluding them.
How to debug it: separate hard exclusions from weighted edges.
What a senior engineer asks next: should different edge types decay differently?

## interaction strength
Plain-English meaning: the final weight from action type and freshness.
Tiny example from clinics 41-50: Diya's reply beats Omar's fresh but weak view.
Common beginner mistake: letting freshness alone dominate.
How to debug it: compare base weight and decay side by side.
What a senior engineer asks next: do replies, likes, views, and follows need separate caps?

## source path
Plain-English meaning: the exact route from Ada to a candidate.
Tiny example from clinics 41-50: Ada -> backend_club -> javaconf.
Common beginner mistake: storing only the candidate ID.
How to debug it: require `graph_debug_trace` for kept, rejected, and missed rows.
What a senior engineer asks next: can this path be replayed offline?

## graph candidate
Plain-English meaning: an item, person, or community found by graph retrieval.
Tiny example from clinics 41-50: `maya` is a graph candidate from mutual friends.
Common beginner mistake: assuming ranking found the candidate.
How to debug it: trace the graph source first, then ranking later.
What a senior engineer asks next: which source produced the candidate and at what cost?

## missing graph candidate
Plain-English meaning: a candidate that never reached ranking because graph retrieval failed or excluded it.
Tiny example from clinics 41-50: `post_201` misses because an edge was not ingested in clinic 49.
Common beginner mistake: labeling every missing row `low_score`.
How to debug it: classify ingestion, expiry, block path, weak community, and quota misses separately.
What a senior engineer asks next: which missing class is growing in telemetry?

## graph debug trace
Plain-English meaning: a readable row explaining kept, rejected, and missed graph decisions.
Tiny example from clinics 41-50: clinic 50 traces follow, mutual, bipartite, community, event, and fresh-edge paths.
Common beginner mistake: tracing only successful candidates.
How to debug it: require traces for kept, rejected, and missed IDs.
What a senior engineer asks next: can support answer a user complaint from this trace?
