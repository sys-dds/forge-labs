# How To Explain In Interview

## Direct answer

Model design a small marketplace + creator ecosystem model combining creators, exposure budgets, buyer intent, listings, seller quality, offers/bookings, supply/demand, and marketplace trust. with `buyers`, `sellers`, `creators`, `creator_profiles`, `creator_content`, `exposure_budget_windows`, `exposure_events`, `buyer_intents`, `listings`, `listing_tags`, `listing_availability`, `offers`, `bookings`, `orders`, `seller_response_events`, `seller_reviews`, `disputes`, `seller_quality_components`, `seller_trust_components`, `local_supply_snapshots`, `local_demand_snapshots`, `marketplace_risk_events`, `marketplace_treatments`, then prove the read contract from source rows instead of a memorised answer.

## Actual tables

Use `buyers`, `sellers`, `creators`, `creator_profiles`, `creator_content`, `exposure_budget_windows`, `exposure_events`, `buyer_intents`, `listings`, `listing_tags`, `listing_availability`, `offers`, `bookings`, `orders`, `seller_response_events`, `seller_reviews`, `disputes`, `seller_quality_components`, `seller_trust_components`, `local_supply_snapshots`, `local_demand_snapshots`, `marketplace_risk_events`, `marketplace_treatments` in schema `bip_pim_025`.

## Actual trap rows

Ada searches cleaning, QuietCraft receives the fair exposure slot, listing 1001 matches intent, RiskSeller is reviewed from component rows, pending offer 1201 is not a booking, and fraud risk event 1701 downranks listing 1002. Ada is the buyer/viewer row used when the clinic needs a named person to test the read contract.

## Exact query mechanics

Join exposure budgets, buyer intent components, listing availability, seller quality and trust components, offer/booking lifecycle, supply/demand snapshots, risk events, and treatments into marketplace_debug_trace_contract.

## Write path

Write creator exposure, buyer intent, listing, seller quality, offer/booking, supply/demand, risk, and treatment rows as separate source rows.

## Marketplace/product follow-up

Ask which row explains the final marketplace result: exposure, intent, quality, booking lifecycle, supply/demand, or risk treatment.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached marketplace read models.
