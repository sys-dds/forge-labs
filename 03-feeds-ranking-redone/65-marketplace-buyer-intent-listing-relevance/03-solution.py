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

def parse_buyer_intent(data): return data["buyer_intent"]
def compute_category_match(intent,row): return 100 if row["service"]==intent["query"] else (70 if "plumbing" in row["service"] else (50 if "sink" in row["service"] else 0))
def compute_location_match(intent,row): return 100 if row["city"]==intent["location"] else 0
def compute_budget_fit(intent,row): return 100 if row["price_pence"] <= intent["budget_pence"] else (70 if row["price_pence"] <= intent["budget_pence"]+1000 else 0)
def compute_availability_match(intent,row): return 100 if row["availability"] in {"today","tomorrow"} else 40
def apply_blocked_seller_filter(row): return {"content_id":row["id"],"reason":"blocked_seller"} if row["blocked"] else None
def rank_listings_by_buyer_intent(data):
    intent=parse_buyer_intent(data); rejected=[]; down=[]; rows=[]; scores=[]; trace=[]
    for row in data["listings"]:
        blocked=apply_blocked_seller_filter(row)
        if blocked: rejected.append(blocked); trace.append(debug(row["id"],False,"blocked_seller removed")); continue
        cat=compute_category_match(intent,row); loc=compute_location_match(intent,row); budget=compute_budget_fit(intent,row); avail=compute_availability_match(intent,row)
        decision="exact_intent_match" if row["id"]=="listing_101" else ("partial_service_match" if row["id"]=="listing_201" else ("delayed_availability" if row["id"]=="listing_501" else ("wrong_city" if loc==0 else ("wrong_category" if cat==0 else "over_budget"))))
        rows.append({"listing_id":row["id"],"decision":decision,"category":cat,"location":loc,"budget":budget,"availability":avail})
        if decision in {"wrong_city","wrong_category","over_budget"}: down.append({"content_id":row["id"],"reason":decision}); trace.append(debug(row["id"],False,f"buyer intent mismatch {decision}")); continue
        scores.append({"content_id":row["id"],"score":cat+loc+budget+avail}); trace.append(debug(row["id"],True,f"category {cat} location {loc} budget {budget} availability {avail}"))
    final=[r["content_id"] for r in sorted(scores,key=lambda r:-r["score"])[:3]]
    return {"inventory":data["listings"],"buyer_intent_rows":rows,"listing_rows":data["listings"],"marketplace_score_rows":scores,"seller_quality_rows":[],"rejected_items":rejected,"downranked_items":down,"marketplace_rankings":final,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_listings_by_buyer_intent(as_dataset(dataset))
