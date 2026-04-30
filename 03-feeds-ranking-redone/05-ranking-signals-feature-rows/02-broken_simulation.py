import json
from pathlib import Path
from collections import Counter, defaultdict


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def rank_by_raw_likes(items): return sorted(items, key=lambda item: item.get("likes",0), reverse=True)
def run(dataset):
    data=load_dataset(dataset); ranked=rank_by_raw_likes(data["content"]); final=[item["id"] for item in ranked[:5]]
    return {"inventory":[item["id"] for item in data["content"]],"eligible_ids":final,"rejected_items":[],"feature_rows":{},"ranked_items":final,"final_feed":final,"debug_trace":[]}
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
