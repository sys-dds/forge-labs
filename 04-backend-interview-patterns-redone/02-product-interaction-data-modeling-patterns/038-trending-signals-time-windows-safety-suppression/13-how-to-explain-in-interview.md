# How To Explain In Interview

## Direct answer

Use trend windows and component rows for velocity, unique actors, and freshness, then join abuse and policy treatment rows before producing a trend surface.

## Actual tables

- `topics`
- `posts`
- `interaction_events`
- `trend_windows`
- `trend_signal_components`
- `abuse_signal_events`
- `policy_treatments`
- `trend_snapshots`

## Actual trap rows

- Topic 101 Build Systems has velocity component 4001.
- Topic 102 Giveaway Spam has raw events but hide treatment 7001.
- Topic 103 Old Launch has stale freshness component 4009.
- Trend window 3001 is the active 24 hour window.
- Snapshot 8001 total derives from component rows 4001 through 4003.

## Exact query mechanics

The query builds component_totals, suppressed_topics, and allowed_trends, then emits velocity_component, safe_trend_allowed, spam_trend_suppressed, and trend_debug_trace.

## Write path

Create trend window 3001. Insert interaction events for topics 101, 102, and 103. Insert velocity, unique_actor, and freshness components. Write abuse evidence 6001 and policy treatment 7001 for spam topic 102.

## Discovery/product follow-up

The product can explain that a topic trended because of velocity and unique actors, or disappeared because of spam treatment.

## Scaling follow-up

At larger size, snapshots can be precomputed from components, but components remain the debug contract.
