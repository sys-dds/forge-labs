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


def rank_everything_by_relevance(rows):
    return sorted(rows, key=lambda row: row.get("relevance", 0), reverse=True)


def run(dataset_path):
    data = load_dataset(dataset_path)
    ranked = rank_everything_by_relevance(data["content"])
    ids = [row["id"] for row in ranked[:5]]
    return {"inventory": inventory(data), "eligible_candidates": ranked, "rejected_items": [], "candidate_rows": [], "ranked_items": ids, "following_feed": ids, "for_you_feed": ids, "final_feed": ids, "debug_trace": []}
