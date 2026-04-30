# Data Model

## Actual tables

`sellers`, `listings`, `orders`, `seller_response_events`, `seller_reviews`, `disputes`, `seller_quality_components`, `seller_quality_snapshots`

## Trap rows

Ada sees BrightSeller boosted from fulfilled orders, quick responses, and reviews, while RiskSeller is reviewed after cancellation and dispute components.

## Constraints

Use source rows for lifecycle and component math. Do not collapse the model into one opaque marketplace score, one static popularity rank, or one boolean trust flag.
