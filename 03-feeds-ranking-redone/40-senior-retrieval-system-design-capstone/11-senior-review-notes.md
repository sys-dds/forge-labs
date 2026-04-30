# Senior Review Notes

## Review questions

- Does every source have a purpose and failure mode?
- Can ranking explain every candidate with source, score, and trace?
- Are index freshness and embedding version policies explicit?

## Telemetry

Log source, item ID, score, trace ID, index version, embedding version, blending quota, evaluation cohort, and ranking handoff position.

## Remaining failure mode

The capstone does not model live serving latency, source outages, online feature stores, or learned model training.

## Larger-scale change

Add source-level replay, recall dashboards, freshness monitors, and missing-candidate debugger integration.

## Do not over-engineer yet

Keep this as a deterministic architecture simulator without service infrastructure or external dependencies.
