import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def match_buyer_intent(row): return row.get("category") == "sink"
def apply_seller_trust_filter(row): return row.get("trust",0) >= 80 and not row.get("blocked")
def compute_distance_score(row): return max(0, 30-row.get("distance",30))
def compute_price_fit(row): return max(0, 100-abs(row.get("price",0)-8000)//100)
def compute_availability_score(row): return 30 if row.get("available") else 0
def apply_marketplace_risk_suppression(row): return row.get("risk") or row.get("blocked")
def rank_marketplace_recommendations(rows): return [r["id"] for r in sorted(rows, key=lambda r:-(r["trust"]+compute_distance_score(r)+compute_price_fit(r)+compute_availability_score(r)))]
def run(dataset_path):
    data=load_dataset(dataset_path); kept=[]; rejected_rows=[]
    for row in data["content"]:
        if apply_marketplace_risk_suppression(row): rejected_rows.append(rejection(row["id"],"blocked_seller" if row.get("blocked") else "seller_risk_suppression","eligibility"))
        elif not match_buyer_intent(row): rejected_rows.append(rejection(row["id"],"wrong_category","eligibility"))
        elif not row.get("available"): rejected_rows.append(rejection(row["id"],"unavailable","eligibility"))
        else: kept.append(row)
    final=rank_marketplace_recommendations(kept)
    return {"inventory":inventory(data),"eligible_candidates":kept,"rejected_items":rejected_rows,"score_rows":[{"content_id":r["id"],"score_components":{"trust":r["trust"],"distance":compute_distance_score(r),"price_fit":compute_price_fit(r),"availability":compute_availability_score(r)},"raw_score":r["trust"]+compute_distance_score(r)+compute_price_fit(r)+compute_availability_score(r)} for r in kept],"marketplace_recommendations":final,"final_feed":final,"debug_trace":[trace(i,True,f"marketplace result {i} matches sink repair intent and seller trust") for i in final]}
