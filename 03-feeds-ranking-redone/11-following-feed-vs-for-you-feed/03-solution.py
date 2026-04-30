import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict):
        return dataset_path
    return json.loads(Path(dataset_path).read_text())


def rejection(content_id, reason, stage):
    return {"content_id": content_id, "reason": reason, "stage": stage}


def trace(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}


def inventory(dataset):
    return [item["id"] for item in dataset["content"]]


def apply_hard_exclusions(rows):
    kept, rejected_rows = [], []
    for row in rows:
        if row.get("muted"):
            rejected_rows.append(rejection(row["id"], "muted_author", "eligibility"))
        elif row.get("blocked"):
            rejected_rows.append(rejection(row["id"], "blocked_author", "eligibility"))
        elif not row.get("safe", True):
            rejected_rows.append(rejection(row["id"], "unsafe_content", "eligibility"))
        else:
            kept.append(row)
    return kept, rejected_rows


def build_following_candidates(rows):
    return [row for row in rows if row.get("followed")]


def build_for_you_candidates(rows):
    return [row for row in rows if row.get("followed") or row["source"] in {"similar_topic", "exploration"}]


def rank_following_chronologically(rows):
    return [row["id"] for row in sorted(rows, key=lambda row: row["age"])]


def rank_for_you_by_relevance(rows):
    return [row["id"] for row in sorted(rows, key=lambda row: (-row["relevance"], row["age"]))]


def explain_surface_difference(following_ids, for_you_ids):
    notes = []
    for item_id in following_ids:
        notes.append(trace(item_id, True, f"content {item_id} appears in Following because Ada follows the author"))
    for item_id in for_you_ids:
        notes.append(trace(f"for_you:{item_id}", True, f"content {item_id} appears in For You because relevance or exploration fits Ada"))
    return notes


def run(dataset_path):
    data = load_dataset(dataset_path)
    eligible, rejected_rows = apply_hard_exclusions(data["content"])
    following = rank_following_chronologically(build_following_candidates(eligible))
    for_you = rank_for_you_by_relevance(build_for_you_candidates(eligible))
    candidates = [{"content_id": row["id"], "source": row["source"], "source_actor": row["author"], "reasons": ["followed_author" if row.get("followed") else row["source"]]} for row in eligible]
    return {"inventory": inventory(data), "eligible_candidates": eligible, "rejected_items": rejected_rows, "candidate_rows": candidates, "ranked_items": for_you, "following_feed": following, "for_you_feed": for_you, "final_feed": for_you, "debug_trace": explain_surface_difference(following, for_you), "feedback_events": []}
