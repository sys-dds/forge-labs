# Debugging Feed Output

## Seen item question

Plain-English meaning: explain why an item is in the feed.

Tiny example from clinic 22: 501 appears because Diya liked it and it matches the backend topic.

Common beginner mistake: returning a broad explanation without source or feature evidence.

How to debug it: inspect candidate source, feature trace, score trace, safety trace, and mixing trace.

What a senior engineer asks next: can the explanation survive an audit after the model changes?

## Missing item question

Plain-English meaning: explain the first stage that removed an item.

Tiny example from clinic 23: 601 was not retrieved, while 801 was stale outside the freshness window.

Common beginner mistake: calling everything low score.

How to debug it: check retrieval, eligibility, scoring, diversity, seen state, and freshness in order.

What a senior engineer asks next: is the first removal reason logged once and preserved?

## Regression question

Plain-English meaning: compare a derived feed against a known good feed.

Tiny example from clinic 21: actual_feed and golden_feed must both be [101, 501, 601, 901].

Common beginner mistake: accepting a feed that has the right length but wrong IDs.

How to debug it: list missing_from_actual and unexpected_actual rows.

What a senior engineer asks next: which regression should block the PR?

## Incident question

Plain-English meaning: connect a bad feed to root causes and mitigations.

Tiny example from clinic 29: [701, 101, 102, 103, 801] points to missing eligibility, diversity, freshness, dedupe, and exploration protections.

Common beginner mistake: patching one bad ID and leaving the disabled layer broken.

How to debug it: run reproduction, diagnosis, mitigation, and regression checks in that order.

What a senior engineer asks next: how quickly can on-call prove the mitigation worked?
