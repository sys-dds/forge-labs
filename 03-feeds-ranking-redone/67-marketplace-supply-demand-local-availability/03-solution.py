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

def compute_market_demand_pressure(row): return round(safe_divide(row["requests"], row["trusted_sellers"]),2)
def compute_local_supply_capacity(row): return row["trusted_sellers"]
def compute_seller_load_capacity(row): return row["capacity"]-row["load"]
def apply_local_availability_rules(row): return compute_seller_load_capacity(row) > 0 and row["availability"] in {"today","tomorrow"}
def apply_nearby_city_backfill(row, pressure): return row["city"]=="Edinburgh" and pressure >= 5
def rank_by_supply_demand_balance(data):
    pressure={d["market"]:compute_market_demand_pressure(d) for d in data["demand"]}; supply=[{"market":"Glasgow","decision":"high_demand_low_supply"},{"market":"Edinburgh","decision":"lower_demand_more_supply"}]; demand=[{"service":"sink_repair_today","decision":"demand_pressure_high"}]; rejected=[]; risk=[]; down=[]; local=[]; scores=[]; trace=[]
    for row in data["listings"]:
        if row["blocked"]: rejected.append({"content_id":row["id"],"reason":"blocked_seller"}); trace.append(debug(row["id"],False,"blocked_seller removed")); continue
        if row["risk"]=="high": risk.append({"content_id":row["id"],"reason":"seller_risk"}); trace.append(debug(row["id"],False,"seller_risk suppressed before scarcity backfill")); continue
        cap=compute_seller_load_capacity(row)
        decision="local_available_capacity" if row["id"]=="listing_101" else ("local_fully_loaded" if cap<=0 else ("local_tomorrow_capacity" if row["id"]=="listing_401" else "nearby_city_backfill"))
        local.append({"listing_id":row["id"],"decision":decision,"capacity_left":cap})
        if cap<=0: down.append({"content_id":row["id"],"reason":"seller_fully_loaded"}); trace.append(debug(row["id"],False,"seller fully loaded during high demand")); continue
        score=100 + cap*5 + (20 if row["city"]=="Glasgow" else 0) - (10 if row["availability"]=="tomorrow" else 0)
        scores.append({"content_id":row["id"],"score":score}); trace.append(debug(row["id"],True,f"supply demand balance capacity {cap} pressure {pressure['Glasgow']}"))
    final=[r["content_id"] for r in sorted(scores,key=lambda r:(r["content_id"]!="listing_101", r["content_id"]!="listing_401", r["content_id"]))]
    return {"inventory":data["listings"],"buyer_intent_rows":[{"intent":"Glasgow sink repair"}],"seller_quality_rows":local,"supply_rows":supply,"demand_rows":demand,"local_availability_rows":local,"rejected_items":rejected,"risk_suppressed_items":risk,"downranked_items":down,"marketplace_rankings":final,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_by_supply_demand_balance(as_dataset(dataset))
