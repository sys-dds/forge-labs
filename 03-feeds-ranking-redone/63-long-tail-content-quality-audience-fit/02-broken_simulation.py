import json
from pathlib import Path

def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset

def debug(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}

def run(dataset):
    data=as_dataset(dataset); ranked=sorted(data["content"],key=lambda r:-r["engagement"]); feed=[r["id"] for r in ranked[:4]]; tr=[debug(x,True,"engagement only") for x in feed]
    return {"inventory":data["content"],"rejected_items":[],"downranked_items":[],"final_feed":feed,"ecosystem_debug_trace":tr,"debug_trace":tr}
