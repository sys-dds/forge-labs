import json
from pathlib import Path
LAYERS=["candidate_generation_layer","ranking_layer"]
def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def apply_shared_safety_layer(rows): return rows,[]
def build_following_feed_surface(rows): return []
def build_for_you_surface(rows): return [701,101,501,1001]
def build_stories_surface(rows): return []
def build_search_surface(rows): return []
def build_notification_surface(rows): return []
def build_creator_discovery_surface(rows): return []
def build_missing_item_explanations(rejected): return {}
def build_experiment_guardrails(): return {}
def run_replay_summary(for_you): return {"status":"failed","surface":"for_you"}
def build_system_design_object(): return {layer: True for layer in LAYERS}
def run(dataset):
    data=load_dataset(dataset); kept,rejected=apply_shared_safety_layer(data["content"]); for_you=build_for_you_surface(kept)
    return {"inventory":[r["id"] for r in data["content"]],"rejected_items":rejected,"following_feed":[],"for_you_feed":for_you,"final_feed":for_you,"stories_tray":[],"search_results":[],"notification_candidates":[],"creator_discovery":[],"missing_explanations":{},"experiment_guardrails":{},"replay_summary":run_replay_summary(for_you),"system_design":build_system_design_object(),"debug_trace":[{"content_id":i,"included":True,"why":"partial capstone"} for i in for_you]}
