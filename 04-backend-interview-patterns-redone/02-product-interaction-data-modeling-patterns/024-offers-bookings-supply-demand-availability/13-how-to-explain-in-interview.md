# How To Explain In Interview

## Direct answer

Model design offers, bookings, supply/demand balance, and local availability for a marketplace. with `buyers`, `sellers`, `listings`, `offers`, `bookings`, `listing_availability_windows`, `seller_capacity_windows`, `buyer_demand_events`, `local_supply_snapshots`, `local_demand_snapshots`, then prove the read contract from source rows instead of a memorised answer.

## Actual tables

Use `buyers`, `sellers`, `listings`, `offers`, `bookings`, `listing_availability_windows`, `seller_capacity_windows`, `buyer_demand_events`, `local_supply_snapshots`, `local_demand_snapshots` in schema `bip_pim_024`.

## Actual trap rows

Ada has pending offer 301 with no booking, accepted offer 302 links booking 401, cancelled booking 402 releases capacity, and North cleaning has high demand against low supply. Ada is the buyer/viewer row used when the clinic needs a named person to test the read contract.

## Exact query mechanics

Separate offer lifecycle from booking lifecycle, subtract active/completed bookings from capacity, join local supply and demand snapshots, and emit availability_debug_trace.

## Write path

Write offers first, create bookings only for accepted offers, record cancellations as booking state, and update supply/demand snapshots separately.

## Marketplace/product follow-up

Ask whether a row is an offer, a booking, a capacity reservation, or a demand signal.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached marketplace read models.
