# Data Model

## Actual tables

`buyers`, `sellers`, `creators`, `creator_profiles`, `creator_content`, `exposure_budget_windows`, `exposure_events`, `buyer_intents`, `listings`, `listing_tags`, `listing_availability`, `offers`, `bookings`, `orders`, `seller_response_events`, `seller_reviews`, `disputes`, `seller_quality_components`, `seller_trust_components`, `local_supply_snapshots`, `local_demand_snapshots`, `marketplace_risk_events`, `marketplace_treatments`

## Trap rows

Ada searches cleaning, QuietCraft receives the fair exposure slot, listing 1001 matches intent, RiskSeller is reviewed from component rows, pending offer 1201 is not a booking, and fraud risk event 1701 downranks listing 1002.

## Constraints

Use source rows for lifecycle and component math. Do not collapse the model into one opaque marketplace score, one static popularity rank, or one boolean trust flag.
