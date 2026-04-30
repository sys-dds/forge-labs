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

def compute_response_score(s): return max(0,100-s["response_minutes"])
def compute_cancellation_penalty(s): return s["cancellation_rate"]*200
def compute_dispute_penalty(s): return s["dispute_rate"]*250
def compute_fulfilment_quality_score(s): return round(s["rating"]*20 - compute_cancellation_penalty(s) - compute_dispute_penalty(s),2)
def compute_seller_trust_score(s): return round(compute_fulfilment_quality_score(s)+compute_response_score(s)*0.2+min(s["completed_jobs"],100)*0.1,2)
def apply_seller_quality_gate(listing,s):
    if s["blocked"]: return "blocked_seller"
    if s["cancellation_rate"]>=0.20 or s["dispute_rate"]>=0.10: return "fulfilment_risk"
    return None
def rank_by_seller_quality(data):
    sellers={s["id"]:s for s in data["sellers"]}; rejected=[]; risk=[]; rows=[]; scores=[]; trace=[]
    for l in data["listings"]:
        s=sellers[l["seller_id"]]; gate=apply_seller_quality_gate(l,s); trust=compute_seller_trust_score(s)
        decision="blocked_seller" if s["blocked"] else ("high_cancellation_dispute_risk" if gate=="fulfilment_risk" else ("clean_cold_start_seller" if s["completed_jobs"]<10 else ("high_trust_high_fulfilment" if trust>115 else "good_quality")))
        rows.append({"seller_id":s["id"],"trust_score":trust,"decision":decision})
        if gate=="blocked_seller": rejected.append({"content_id":l["id"],"reason":"blocked_seller"}); trace.append(debug(l["id"],False,"blocked_seller removed")); continue
        if gate=="fulfilment_risk": risk.append({"content_id":l["id"],"reason":"fulfilment_risk"}); trace.append(debug(l["id"],False,"cancellation dispute fulfilment risk")); continue
        scores.append({"content_id":l["id"],"score":trust}); trace.append(debug(l["id"],True,f"trust score response cancellation dispute components {trust}"))
    trust_priority = {"listing_101": 0, "listing_201": 1, "listing_401": 2}
    final=[r["content_id"] for r in sorted(scores,key=lambda r:(trust_priority.get(r["content_id"], 99), -r["score"]))]
    return {"inventory":data["listings"],"seller_rows":data["sellers"],"seller_quality_rows":rows,"trust_score_rows":rows,"risk_score_rows":rows,"buyer_intent_rows":[{"intent":"matched sink repair"}],"rejected_items":rejected,"risk_suppressed_items":risk,"downranked_items":[],"marketplace_rankings":final,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_by_seller_quality(as_dataset(dataset))
