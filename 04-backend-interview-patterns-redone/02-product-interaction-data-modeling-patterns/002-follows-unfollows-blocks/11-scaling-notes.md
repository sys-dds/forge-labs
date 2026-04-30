# Scaling Notes

Keep this model small first. Later options include denormalised counters, read models, cache entries, and fanout jobs, but the clinic intentionally proves the relational source of truth before adding operational machinery.

Later, follower counts can be materialised per user after the source query is proven.
