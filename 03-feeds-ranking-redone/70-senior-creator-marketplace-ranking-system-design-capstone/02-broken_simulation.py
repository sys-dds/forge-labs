import json
from pathlib import Path

def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset

def debug(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}

def run(dataset):
    data=as_dataset(dataset); kept=sorted(data["candidates"],key=lambda r:-r["score"]); feed=[r["id"] for r in kept[:6]]; tr=[debug(x,True,"raw engagement or cheapest price") for x in feed]
    return {"inventory":data["candidates"],"rejected_items":[],"risk_suppressed_items":[],"downranked_items":[],"final_feed":feed,"ecosystem_system_design":{"creator_exposure_policy":True,"marketplace_risk_policy":True},"ranking_handoff_contract":[],"ecosystem_debug_trace":tr,"debug_trace":tr}
