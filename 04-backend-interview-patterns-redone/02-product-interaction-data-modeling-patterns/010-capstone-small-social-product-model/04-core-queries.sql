SET search_path TO bip_pim_010;
-- Compose small contracts: profile visibility uses profiles/follows/blocks; counts ignore deleted rows; match uses canonical active matches; notifications count unread; activity and home feed filter deleted, blocked, inactive, and followed state; recommendation candidates use shared interests with exclusions.
