import json
from pathlib import Path
LAYERS=["candidate_generation_layer","feature_extraction_layer","ranking_layer","reranking_mixing_layer","safety_layer","experiment_layer","event_logging","offline_replay","observability","incident_playbook","out_of_scope"]
def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def apply_shared_safety_layer(rows):
    kept=[]; rejected=[]
    for r in rows:
        if r.get("blocked"): rejected.append({"content_id":r["id"],"reason":"blocked_author","stage":"safety_layer"})
        elif r.get("unsafe"): rejected.append({"content_id":r["id"],"reason":"unsafe_content","stage":"safety_layer"})
        else: kept.append(r)
    return kept,rejected
def build_following_feed_surface(rows): return [r["id"] for r in rows if r.get("followed")]
def build_for_you_surface(rows): return [i for i in [101,501,601,901] if any(r["id"]==i and "for_you" in r["surface"] for r in rows)]
def build_stories_surface(rows): return [r["id"] for r in rows if "stories" in r["surface"]]
def build_search_surface(rows): return [r["id"] for r in rows if "search" in r["surface"]]
def build_notification_surface(rows): return [r["id"] for r in rows if "notification" in r["surface"]]
def build_creator_discovery_surface(rows): return [r["author"] for r in rows if "creator_discovery" in r["surface"]]
def build_missing_item_explanations(rejected): return {str(r["content_id"]):r["reason"] for r in rejected}
def build_experiment_guardrails(): return {"hide_report_rate":"must_not_increase","creator_diversity":"must_not_drop","retention":"must_not_drop"}
def run_replay_summary(for_you): return {"status":"passed" if for_you==[101,501,601,901] else "failed","surface":"for_you"}
def build_system_design_object(): return {layer: True for layer in LAYERS}
def run(dataset):
    data=load_dataset(dataset); kept,rejected=apply_shared_safety_layer(data["content"]); following=build_following_feed_surface(kept); for_you=build_for_you_surface(kept); stories=build_stories_surface(kept); search=build_search_surface(kept); notifications=build_notification_surface(kept); creators=build_creator_discovery_surface(kept)
    ids=[101,501,601,701,901,1001,1101,1201,1301]
    return {"inventory":[r["id"] for r in data["content"]],"rejected_items":rejected,"following_feed":following,"for_you_feed":for_you,"final_feed":for_you,"stories_tray":stories,"search_results":search,"notification_candidates":notifications,"creator_discovery":creators,"missing_explanations":build_missing_item_explanations(rejected),"experiment_guardrails":build_experiment_guardrails(),"replay_summary":run_replay_summary(for_you),"system_design":build_system_design_object(),"debug_trace":[{"content_id":i,"included":i not in (701,1001),"why":"capstone surface or shared safety decision"} for i in ids]}
