# Interview Explanation

## Direct answer

marketplace recommendations needs ranking rules aligned to user intent.

## Dataset walkthrough

The named rows include valid candidates, tempting wrong candidates, and rejected rows.

## Ranking reasoning

The solution filters first, computes explicit signals, ranks deterministically, and writes debug traces.

## Common mistake

A common mistake is letting popularity or one raw count dominate every product surface.

## Senior trade-off

Keep the model simple enough to replay while preserving hard filters and explainability.

## Follow-up answer

I would compare offline replay output before changing weights in a larger system.
