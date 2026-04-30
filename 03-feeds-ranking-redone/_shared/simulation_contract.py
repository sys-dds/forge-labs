"""Shared result contract for feeds ranking redone clinics.

Every simulation exposes run(dataset: dict) -> dict. Clinics may add surface-specific
keys, but proofs rely on these names when they are relevant.
"""

REQUIRED_BASE_KEYS = ("rejected_items", "debug_trace")
RANKING_KEYS = ("feature_rows", "score_rows")


def empty_result():
    return {
        "inventory": [],
        "eligible_candidates": [],
        "rejected_items": [],
        "candidate_rows": [],
        "feature_rows": [],
        "score_rows": [],
        "ranked_items": [],
        "final_feed": [],
        "debug_trace": [],
        "feedback_events": [],
    }


def rejection(content_id, reason, stage):
    return {"content_id": content_id, "reason": reason, "stage": stage}


def trace(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}
