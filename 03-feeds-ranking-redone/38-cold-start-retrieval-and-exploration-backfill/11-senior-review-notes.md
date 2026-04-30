# Senior Review Notes

## Review questions

- Which retrieval source found each item?
- Which relevant item was missed before ranking?
- Which policy prevents the miss from becoming an incident?

## Telemetry

Log item ID, source, source quota, index version, embedding version, match score, miss reason, rejection reason, and handoff order.

## Remaining failure mode

The clinic does not simulate traffic skew, learned embedding drift, partial index outages, or serving latency spikes.

## Larger-scale change

Add source-level replay, index freshness monitors, and missing-candidate debug tooling for every ranking handoff.

## Do not over-engineer yet

Keep the simulator deterministic and avoid external retrieval infrastructure.
