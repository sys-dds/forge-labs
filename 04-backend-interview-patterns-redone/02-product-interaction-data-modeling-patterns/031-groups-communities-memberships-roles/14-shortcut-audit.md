# Shortcut Audit

## Likely shortcut

A single membership_exists boolean or users.is_admin flag.

## How base proof catches it

Base data has Cy left, Diya banned, Ben moderator, and Eli member rows; the broken query treats them too broadly and disagrees with expected CSV.

## How variant proof catches it

The variant proof catches role, access, visibility, RSVP, or moderation shortcuts by changing real rows while keeping the same verification query. Ben loses remove_post in the variant, so a hard-coded moderator answer fails.

## What mutation should fail

Change permission 9002 from true to false for role 203; moderator_permission_contract must change.

## What learner should inspect manually

Inspect `bip_pim_031` seed rows, especially membership 1003, ban 7001, role assignment 5002, and permission 9002.
