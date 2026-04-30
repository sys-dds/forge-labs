# Ranking Debugging Playbook

## Start with the item ID

Plain-English meaning: debug one row at a time from retrieval to final placement.

Tiny example from clinic 23: item 601 is absent because it was not retrieved, while 401 was retrieved but below the score cutoff.

Common beginner mistake: calling every missing item low score.

How to debug it: ask which stage first removed the item: retrieval, eligibility, scoring, diversity, seen state, or freshness.

What a senior engineer asks next: do logs preserve the first removal reason?

## Explain seen items

Plain-English meaning: show the source, features, score, safety decision, and mixing reason for an item that appeared.

Tiny example from clinic 22: item 901 appears because the exploration slot was reserved.

Common beginner mistake: returning a vague message like recommended for you.

How to debug it: require trace text with the actual source or rule.

What a senior engineer asks next: can support answer both why seen and why not seen from the same trace pipeline?

## Incident replay

Plain-English meaning: reproduce a bad feed, diagnose root causes, apply mitigations, and keep regression checks.

Tiny example from clinic 29: bad_feed [701, 101, 102, 103, 801] reveals missing eligibility, diversity, freshness, dedupe, and exploration rules.

Common beginner mistake: fixing the visible bad item without restoring the disabled layer.

How to debug it: map each symptom to one root cause and one mitigation.

What a senior engineer asks next: which regression check prevents the same incident next week?
