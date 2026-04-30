# Objects, Relationships, Events, Read Models

Product interaction systems usually start with durable objects, then relationship tables, then event history, then read models. Keep the first model boring and correct: primary keys, uniqueness rules, lifecycle states, and query contracts. Add caches or denormalised counters later only when the read path demands it.
