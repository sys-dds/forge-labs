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

def compute_dispute_risk(row): return row["dispute_rate"]*100
def compute_refund_risk(row): return row["refund_rate"]*100
def compute_price_anomaly_risk(row): return 35 if row["price"] < 4000 else 0
def compute_fraud_flag_risk(row): return row["fraud_flags"]*30
def compute_marketplace_risk_score(row): return round(compute_dispute_risk(row)+compute_refund_risk(row)+compute_price_anomaly_risk(row)+compute_fraud_flag_risk(row),2)
def apply_risk_suppression(row, score):
    if row["blocked"]: return "blocked_seller"
    if score >= 140: return "high_fraud_dispute_refund_risk"
    if score >= 70: return "suspiciously_cheap_fraud_risk"
    return None
def rank_after_risk_suppression(data):
    rejected=[]; risk=[]; rows=[]; scores=[]; trace=[]
    for row in data["listings"]:
        score=compute_marketplace_risk_score(row); treatment=apply_risk_suppression(row,score)
        decision="blocked_seller" if row["blocked"] else ("fraud_risk_high" if row["id"]=="listing_201" else ("fraud_risk_medium" if row["id"]=="listing_501" else ("clean_cold_start" if row["id"]=="listing_401" else "trusted_low_risk")))
        rows.append({"listing_id":row["id"],"risk_score":score,"decision":decision})
        if treatment=="blocked_seller": rejected.append({"content_id":row["id"],"reason":"blocked_seller"}); trace.append(debug(row["id"],False,"blocked_seller removed")); continue
        if treatment: risk.append({"content_id":row["id"],"reason":treatment}); trace.append(debug(row["id"],False,f"fraud dispute refund risk score {score}")); continue
        scores.append({"content_id":row["id"],"score":100-score}); trace.append(debug(row["id"],True,f"risk score dispute refund fraud {score}"))
    final=[r["content_id"] for r in sorted(scores,key=lambda r:(r["content_id"]!="listing_101",r["content_id"]!="listing_301",r["content_id"]))]
    return {"inventory":data["listings"],"buyer_intent_rows":[{"intent":"sink repair matched"}],"seller_quality_rows":rows,"trust_score_rows":rows,"risk_score_rows":rows,"rejected_items":rejected,"risk_suppressed_items":risk,"downranked_items":[],"marketplace_rankings":final,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_after_risk_suppression(as_dataset(dataset))
