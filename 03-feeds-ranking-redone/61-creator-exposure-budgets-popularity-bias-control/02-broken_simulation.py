import json
from pathlib import Path

def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset

def debug(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}

def run(dataset):
    data=as_dataset(dataset); creators={c["id"]:c for c in data["creators"]}; ranked=sorted(data["posts"], key=lambda p:-creators[p["creator_id"]]["engagement"]); feed=[p["id"] for p in ranked[:4]]; trace=[debug(p["id"],True,"historical engagement only") for p in ranked[:4]]
    return {"inventory":data["posts"],"rejected_items":[],"downranked_items":[],"creator_rankings":feed,"final_feed":feed,"ecosystem_debug_trace":trace,"debug_trace":trace}
