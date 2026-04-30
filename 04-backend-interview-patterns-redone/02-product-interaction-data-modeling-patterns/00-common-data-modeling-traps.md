# Common Data Modeling Traps

Do not confuse a follow with a friendship. Do not show private profile fields to public viewers. Do not count inactive reactions or soft-deleted comments. Do not create a match from one swipe. Do not show a global recent feed when the product asked for followed authors. Do not notify users about their own actions. Do not treat audit events as user-visible activity. Do not recommend already-followed, already-matched, blocked, or reported users. Do not forget that blocks and reports override otherwise valid relationships.

The clinic proofs catch these mistakes with named rows rather than broad prose: Eli 103 in the feed variant, Ada self-like event 1005, Ben private activity 8002, Hana/Ivan recommendation exclusions, and capstone deleted/blocked rows.
