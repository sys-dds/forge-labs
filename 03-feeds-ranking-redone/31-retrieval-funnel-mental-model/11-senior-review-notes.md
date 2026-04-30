# Senior Review Notes

## Review questions

- Which source found each candidate?
- Which relevant item was missed before ranking?
- Which metric or trace would catch the miss in replay?

## Telemetry

Log content ID, source name, query or user vector version, similarity score, miss reason, rejection reason, and handoff position.

## Remaining failure mode

A small clinic cannot model traffic distribution, source outages, or learned embedding drift across millions of items.

## Larger-scale change

Add sampled retrieval replay, source-level recall dashboards, and missing-candidate debugging for production incidents.

## Do not over-engineer yet

Keep this clinic deterministic and standard-library only; no vector database or ML dependency is needed.
