import json
from pathlib import Path

def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset

def debug(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}

def run(dataset):
    data=as_dataset(dataset); shown=[r["id"] for r in data["items"] if r["status"]=="shown" and r["id"]!="creator_maya"]; missing=[{"content_id":r["id"],"reason":"low_score"} for r in data["items"] if r["status"]=="missing"]; tr=[debug(r["content_id"],False,"low_score") for r in missing]
    return {"inventory":data["items"],"rejected_items":[],"downranked_items":missing,"missing_ecosystem_explanations":missing,"final_feed":shown,"ecosystem_debug_trace":tr,"debug_trace":tr}
