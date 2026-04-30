import json
from pathlib import Path


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def rank_story_tray_without_expiry(items): return [item for item in items if item.get("surface") == "story"]
def rank_spotlight_by_likes(items): return sorted([item for item in items if item.get("surface") == "spotlight"], key=lambda item: item.get("likes",0), reverse=True)
def run(dataset):
    data=load_dataset(dataset); stories=rank_story_tray_without_expiry(data["content"]); spotlight=rank_spotlight_by_likes(data["content"])
    return {"inventory":[item["id"] for item in data["content"]],"eligible_ids":[item["id"] for item in stories+spotlight],"rejected_items":[],"story_tray":[item["id"] for item in stories],"spotlight_feed":[item["id"] for item in spotlight[:2]],"final_feed":[item["id"] for item in stories]+[item["id"] for item in spotlight[:2]],"debug_trace":[]}
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
