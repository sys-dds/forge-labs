# Senior Review Notes

## Review questions

- Does every graph candidate carry a source path?
- Does every missing candidate have a graph-stage reason?
- Are block, mute, safety, quota, and freshness rules applied before ranking?

## Telemetry

Log candidate ID, source path, edge type, score row, exclusion reason, and graph traversal stage.

## Remaining failure mode

A stale or missing edge can silently remove a good candidate unless traces are sampled.

## Larger-scale change

Move from hand-written rows to indexed graph snapshots with replayable traversal logs.

## Do not over-engineer yet

Keep this clinic deterministic; the lesson is inspectable graph behavior, not distributed graph storage.
