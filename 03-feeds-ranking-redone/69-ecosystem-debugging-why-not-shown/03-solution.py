import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from ecosystem_helpers import bounded_score, compute_gap, exposure_ratio, safe_divide, weighted_sum

def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset

def debug(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}

def classify_creator_exposure_miss(row): return row["reason"] if row["stage"]=="exposure_budget" else None
def classify_seller_capacity_miss(row): return row["reason"] if row["stage"]=="supply_capacity" else None
def classify_marketplace_risk_miss(row): return row["reason"] if row["stage"]=="marketplace_risk" else None
def classify_buyer_intent_miss(row): return row["reason"] if row["stage"]=="buyer_intent" else None
def classify_quality_gate_miss(row): return row["reason"] if row["stage"]=="quality_gate" else None
def classify_diversity_cap_miss(row): return row["reason"] if row["stage"]=="ecosystem_diversity" else None
def explain_missing_ecosystem_item(row): return {"content_id":row["id"],"reason":row["reason"],"stage":row["stage"]}
def rank_debuggable(data):
    final=[]; missing=[]; trace=[]
    for row in data["items"]:
        if row["status"]=="shown": final.append(row["id"]); trace.append(debug(row["id"],True,f"shown because {row['reason']} at {row['stage']}"))
        else: missing.append(explain_missing_ecosystem_item(row)); trace.append(debug(row["id"],False,f"{row['reason']} at {row['stage']}"))
    return {"inventory":data["items"],"rejected_items":[],"downranked_items":missing,"missing_ecosystem_explanations":missing,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_debuggable(as_dataset(dataset))
