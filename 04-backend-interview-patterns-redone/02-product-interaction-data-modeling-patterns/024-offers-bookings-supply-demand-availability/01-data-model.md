# Data Model

## Actual tables

`buyers`, `sellers`, `listings`, `offers`, `bookings`, `listing_availability_windows`, `seller_capacity_windows`, `buyer_demand_events`, `local_supply_snapshots`, `local_demand_snapshots`

## Trap rows

Ada has pending offer 301 with no booking, accepted offer 302 links booking 401, cancelled booking 402 releases capacity, and North cleaning has high demand against low supply.

## Constraints

Use source rows for lifecycle and component math. Do not collapse the model into one opaque marketplace score, one static popularity rank, or one boolean trust flag.
