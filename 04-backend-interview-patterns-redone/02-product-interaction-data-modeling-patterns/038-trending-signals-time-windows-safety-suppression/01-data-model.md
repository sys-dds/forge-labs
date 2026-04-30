# Data Model

## Actual tables

- `topics`
- `posts`
- `interaction_events`
- `trend_windows`
- `trend_signal_components`
- `abuse_signal_events`
- `policy_treatments`
- `trend_snapshots`

## Constraints

- Trend windows define which events count.
- Signal components explain velocity, unique actor count, and freshness.
- Spam evidence and policy treatments can suppress an otherwise busy trend.
- Trend snapshots store component-derived totals without replacing components.

## Trap rows

- Topic 101 Build Systems has velocity component 4001.
- Topic 102 Giveaway Spam has raw events but hide treatment 7001.
- Topic 103 Old Launch has stale freshness component 4009.
- Trend window 3001 is the active 24 hour window.
- Snapshot 8001 total derives from component rows 4001 through 4003.

## Why this shape

Trending needs explainable components and suppression evidence. Raw event count alone cannot distinguish safe velocity from spam or old activity.
