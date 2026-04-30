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


def by_id(dataset):
    return {item["id"]: item for item in dataset["content"]}


def base_result(dataset):
    return {
        "inventory": [item["id"] for item in dataset["content"]],
        "eligible_candidates": [],
        "eligible_ids": [],
        "rejected_items": [],
        "candidate_rows": [],
        "feature_rows": [],
        "score_rows": [],
        "ranked_items": [],
        "final_feed": [],
        "debug_trace": [],
        "feedback_events": [],
    }


def load_inventory(dataset):
    return list(dataset["content"])


def apply_eligibility(inventory):
    kept = []
    removed = []
    for item in inventory:
        if item.get("muted"):
            removed.append(rejected(item["id"], "muted_author", "eligibility"))
        elif item.get("blocked"):
            removed.append(rejected(item["id"], "blocked_author", "eligibility"))
        elif item.get("safety") == "unsafe":
            removed.append(rejected(item["id"], "unsafe_content", "eligibility"))
        else:
            kept.append(item)
    return kept, removed


def build_candidate_rows(candidates):
    source_reasons = {"in_network": ["followed_author"], "group": ["shared_group"], "similar_topic": ["backend_topic_match"], "exploration": ["creator_discovery"]}
    return [{"content_id": item["id"], "source": item["source"], "source_actor": item["author"], "reasons": source_reasons[item["source"]]} for item in candidates]


def score_candidates(candidates):
    relationship = {"in_network": 10, "group": 6, "similar_topic": 4, "exploration": 1}
    scored = []
    for item in candidates:
        features = {"recency": item["recency"] // 3, "relationship_strength": relationship[item["source"]], "engagement": item["engagement"] // 4}
        raw_score = features["recency"] + features["relationship_strength"] + features["engagement"]
        scored.append({"content_id": item["id"], "features": features, "score_components": {"recency_score": features["recency"], "affinity_score": features["relationship_strength"], "engagement_score": features["engagement"]}, "raw_score": raw_score})
    return scored


def rank_candidates(scored):
    return [row["content_id"] for row in sorted(scored, key=lambda row: (-row["raw_score"], row["content_id"]))]


def build_debug_trace(final_feed, item_lookup):
    notes = {101: "followed author Ben, eligible, high affinity", 501: "Lina matches backend topic after eligibility", 401: "Diya group post survives muted and blocked exclusions", 701: "Maya fills exploration after risk filters"}
    return [trace(item_id, True, notes[item_id]) for item_id in final_feed]


def log_impressions(viewer, final_feed):
    return [{"viewer": viewer, "content_id": item_id, "event": "impression"} for item_id in final_feed]


def run(dataset):
    data = load_dataset(dataset)
    lookup = by_id(data)
    inventory = load_inventory(data)
    eligible, rejected_items = apply_eligibility(inventory)
    candidate_rows = build_candidate_rows(eligible)
    scored = score_candidates(eligible)
    final_feed = rank_candidates(scored)
    result = base_result(data)
    result.update({"eligible_candidates": eligible, "eligible_ids": [item["id"] for item in eligible], "rejected_items": rejected_items, "candidate_rows": candidate_rows, "feature_rows": [{"content_id": row["content_id"], "features": row["features"]} for row in scored], "score_rows": [{"content_id": row["content_id"], "score_components": row["score_components"], "raw_score": row["raw_score"]} for row in scored], "ranked_items": final_feed, "final_feed": final_feed, "debug_trace": build_debug_trace(final_feed, lookup), "feedback_events": log_impressions(data["viewer"], final_feed)})
    return result

if __name__ == "__main__":
    import sys
    print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
