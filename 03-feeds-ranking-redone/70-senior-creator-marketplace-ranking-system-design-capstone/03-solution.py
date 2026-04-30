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

def build_creator_exposure_policy(): return {"budgets":{"per_creator_page_cap":2,"underexposed_quality_boost":20},"fatigue_caps":{"max_author_posts":2},"long_tail_protection":{"min_quality":75}}
def build_cold_start_policy(): return {"quality_gate":{"sample_quality_min":80},"exploration_slots":{"creator_slots":1,"seller_slots":1},"safety_gates":["blocked_creator","blocked_seller"]}
def build_marketplace_intent_policy(): return {"category":"sink repair","location":"Glasgow","budget":"checked","availability":["today","tomorrow"]}
def build_seller_quality_policy(): return {"response":"minutes_component","fulfilment":"completed_jobs_component","cancellation":"penalty","dispute":"penalty","refund":"penalty"}
def build_supply_demand_policy(): return {"local_scarcity":"Glasgow high demand low supply","load":"exclude full sellers","nearby_backfill":"allow clean nearby supply"}
def build_marketplace_risk_policy(): return {"fraud":"flag component","disputes":"rate component","refunds":"rate component","blocked_sellers":"hard reject"}
def build_fairness_policy(): return {"popularity_bias_controls":["exposure_ratio","author_cap"],"long_tail_metrics":["quality","audience_fit"]}
def rank_creator_candidates(rows): return [r for r in rows if r["type"] in {"post","creator"} and r["treatment"]=="keep"]
def rank_marketplace_candidates(rows): return [r for r in rows if r["type"]=="listing" and r["treatment"]=="keep"]
def blend_creator_and_marketplace_candidates(creators, listings):
    order=["post_101","listing_501","post_201","listing_601","post_301","listing_901"]; by={r["id"]:r for r in creators+listings}; return [by[i] for i in order if i in by]
def build_missing_ecosystem_explanations(rows): return [{"content_id":r["id"],"reason":r["reason"]} for r in rows if r["treatment"]=="missing"]
def build_ranking_handoff_contract(rows): return [{"candidate_id":r["id"],"candidate_type":r["type"],"score_components":{"base":r["score"],"ecosystem_reason":r["reason"]},"treatments":[r["treatment"]],"traces":[f"{r['id']} {r['reason']}"]} for r in rows]
def build_ecosystem_system_design(handoff): return {"creator_exposure_policy":build_creator_exposure_policy(),"cold_start_policy":build_cold_start_policy(),"marketplace_intent_policy":build_marketplace_intent_policy(),"seller_quality_policy":build_seller_quality_policy(),"supply_demand_policy":build_supply_demand_policy(),"marketplace_risk_policy":build_marketplace_risk_policy(),"fairness_policy":build_fairness_policy(),"debugging_policy":{"missing_ecosystem_explanations":"stage and reason required"},"ranking_handoff_contract":{"rows":handoff}}
def run(dataset):
    data=as_dataset(dataset); rows=data["candidates"]; creators=rank_creator_candidates(rows); listings=rank_marketplace_candidates(rows); blended=blend_creator_and_marketplace_candidates(creators,listings); final=[r["id"] for r in blended]
    rejected=[{"content_id":r["id"],"reason":r["reason"]} for r in rows if r["treatment"]=="reject"]; risk=[{"content_id":r["id"],"reason":r["reason"]} for r in rows if r["treatment"]=="risk"]; missing=build_missing_ecosystem_explanations(rows); handoff=build_ranking_handoff_contract(blended); design=build_ecosystem_system_design(handoff)
    trace=[debug(r["id"],r["treatment"]=="keep",f"{r['id']} {r['type']} {r['reason']} treatment {r['treatment']}") for r in rows]
    return {"inventory":rows,"viewer_intent_rows":[data["viewer_buyer"]],"buyer_intent_rows":[data["viewer_buyer"]["marketplace_intent"]],"creator_rows":[r for r in rows if r["type"] in {"post","creator"}],"seller_rows":[r for r in rows if r["type"]=="listing"],"exposure_rows":[{"creator_id":"creator_1001","decision":"exposure_budget_exhausted"}],"fairness_rows":[{"metric":"popularity_bias","decision":"controlled"}],"buyer_intent_score_rows":[{"query":"sink repair","location":"Glasgow"}],"seller_quality_rows":[{"listing_id":"listing_501","decision":"trusted_sink_repair_today"},{"listing_id":"listing_901","decision":"clean_cold_start_seller"}],"trust_score_rows":[{"listing_id":"listing_501","trust":"high"}],"risk_score_rows":[{"listing_id":"listing_701","risk":"high_marketplace_risk"}],"rejected_items":rejected,"risk_suppressed_items":risk,"downranked_items":missing,"missing_ecosystem_explanations":missing,"marketplace_rankings":[r["id"] for r in listings],"creator_rankings":[r["id"] for r in creators],"final_feed":final,"ecosystem_system_design":design,"ranking_handoff_contract":handoff,"ecosystem_debug_trace":trace,"debug_trace":trace}
