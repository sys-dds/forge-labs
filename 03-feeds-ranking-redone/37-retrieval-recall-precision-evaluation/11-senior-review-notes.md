# Senior Review Notes

## Review questions

- Which source found each candidate?
- Which miss would hurt recall?
- Which report would block a bad retrieval change?

## Telemetry

Log item ID, source, quota, match score, recall bucket, miss reason, rejection reason, and ranking handoff fields.

## Remaining failure mode

The small deterministic corpus does not model live index lag, long-tail creators, or traffic segment drift.

## Larger-scale change

Add source-level replay, recall dashboards, and missing-candidate diagnostics tied to incidents.

## Do not over-engineer yet

Keep it standard-library only; no service, notebook, vector database, or ML dependency is needed.
