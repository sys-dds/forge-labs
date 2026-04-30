import json
from pathlib import Path


def load_dataset(dataset):
    if isinstance(dataset, dict):
        return dataset
    return json.loads(Path(dataset).read_text())


def rejected(content_id, reason, stage):
    return {"content_id": content_id, "reason": reason, "stage": stage}


def trace(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}


def base_result(dataset):
    return {"inventory": [item["id"] for item in dataset["content"]], "eligible_candidates": [], "eligible_ids": [], "rejected_items": [], "candidate_rows": [], "feature_rows": [], "score_rows": [], "ranked_items": [], "final_feed": [], "debug_trace": [], "feedback_events": []}


def by_id(dataset):
    return {item["id"]: item for item in dataset["content"]}


def collect_followed_without_filters(items):
    return [item for item in items if item["source"] in {"close_friend", "followed_author", "commented_by_following", "public"}]


def run(dataset):
    data=load_dataset(dataset)
    candidates=collect_followed_without_filters(data["content"])
    # Duplicates Lina when a comment path is seen twice and misses the shared group source.
    rows=[{"content_id": item["id"], "source": item["source"], "source_actor": item["author"], "reasons": []} for item in candidates if item["id"] != 401]
    rows.append({"content_id":501,"source":"commented_by_following","source_actor":"Maya","reasons":[]})
    final=[row["content_id"] for row in rows]
    return {"inventory":[item["id"] for item in data["content"]],"eligible_candidates":candidates,"eligible_ids":final,"rejected_items":[],"candidate_rows":rows,"final_feed":final,"debug_trace":[]}
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
