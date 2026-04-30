# Senior Review Notes

## Review questions

- Which missing-candidate reason is most likely to affect recall?
- Which source quota or index check should alert first?
- Can ranking logs link back to retrieval trace IDs?

## Telemetry

Log item ID, source, index version, embedding version, quota bucket, eligibility decision, ANN probe bucket, and miss reason.

## Remaining failure mode

This deterministic clinic cannot model partial index rollout, delayed embeddings, or per-segment quota shifts.

## Larger-scale change

Add a missing-candidate debugger that joins retrieval logs with ranking handoff logs.

## Do not over-engineer yet

Keep stage classification explicit and small before adding retrieval infrastructure.
