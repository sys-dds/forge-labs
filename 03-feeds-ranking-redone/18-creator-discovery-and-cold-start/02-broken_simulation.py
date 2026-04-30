import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def run(dataset_path):
    data=load_dataset(dataset_path); ranked=sorted(data["content"], key=lambda r:r.get("followers",0), reverse=True); ids=[r["id"] for r in ranked[:4]]
    return {"inventory":inventory(data),"eligible_candidates":ranked,"rejected_items":[],"creator_discovery":ids,"final_feed":ids,"debug_trace":[]}
