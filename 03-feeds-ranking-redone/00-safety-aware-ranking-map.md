# Safety-Aware Ranking Map

Clinics 51-60 add safety and integrity controls to Feeds/Ranking Redone.

- 51: policy taxonomy maps labels to remove, reduce, inform, review, allow.
- 52: hard filters happen before ranking; labels and downranks shape ranking.
- 53: spam, clickbait, and engagement farming suppress raw engagement wins.
- 54: fake engagement and bot rings add authenticity evidence.
- 55: trust score uses account and source quality, not popularity.
- 56: reporter reliability routes review queues.
- 57: sensitive content treatment depends on viewer context.
- 58: appeals and reversals preserve audit lineage.
- 59: safety incidents require root causes and regression checks.
- 60: senior safety-aware design hands treatments, labels, risks, and traces to ranking.

The handoff chain is: content/user/report event -> policy label -> evidence row -> treatment -> trust/risk score -> audit trace -> ranking handoff.

## sensitive content
Tiny row-level example: Ben rejects post_401 because age context disallows the graphic topic.

## borderline content
Tiny row-level example: Ada receives post_201 with an informed medical label instead of removal.

## age/context treatment
Tiny row-level example: clinic 57 gives Ada and Ben different feeds from the same content rows.

## safety incident
Tiny row-level example: clinic 59 diagnoses hard_filter_disabled when post_201 spam appears.

## regression check
Tiny row-level example: clinic 59 requires spam_absent and appeal_reversal_applied.

## safety-aware ranking
Tiny row-level example: clinic 60 sends candidate IDs with treatments, labels, risks, and traces to ranking.
