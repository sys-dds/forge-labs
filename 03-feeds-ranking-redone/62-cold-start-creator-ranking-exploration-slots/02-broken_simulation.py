import json
from pathlib import Path

def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset

def debug(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}

def run(dataset):
    data=as_dataset(dataset); creators={c["id"]:c for c in data["creators"]}; ranked=sorted(data["posts"], key=lambda p:-creators[p["creator_id"]]["historical_engagement"]); feed=[p["id"] for p in ranked[:3]]
    return {"inventory":data["posts"],"rejected_items":[],"downranked_items":[],"final_feed":feed,"creator_rankings":feed,"ecosystem_debug_trace":[debug(x,True,"requires old engagement") for x in feed],"debug_trace":[debug(x,True,"requires old engagement") for x in feed]}
