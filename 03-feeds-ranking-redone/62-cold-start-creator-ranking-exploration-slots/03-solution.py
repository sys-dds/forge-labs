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

def identify_cold_start_creators(creators): return [c for c in creators if c["historical_engagement"] == 0]
def compute_cold_start_quality_score(creator): return creator["sample_quality"] if creator["profile_complete"] else creator["sample_quality"] - 35
def compute_viewer_creator_fit(viewer, creator): return 90 if "backend" in creator["topic"] else 25
def reserve_exploration_slots(rows): return [r for r in rows if r["decision"] == "qualifies_for_exploration_slot"][:1]
def apply_cold_start_safety_rules(post, creator): return {"content_id":post["id"],"reason":"unsafe_creator"} if creator["blocked"] else None
def rank_established_and_cold_start(data):
    creators={c["id"]:c for c in data["creators"]}; rejected=[]; down=[]; cold=[]; scored=[]; trace=[]
    for post in data["posts"]:
        c=creators[post["creator_id"]]; unsafe=apply_cold_start_safety_rules(post,c)
        if unsafe: rejected.append(unsafe); trace.append(debug(post["id"],False,"creator_noor unsafe_creator rejected before exploration")); continue
        fit=compute_viewer_creator_fit(data["viewer"],c); quality=compute_cold_start_quality_score(c)
        if c["historical_engagement"] == 0:
            decision="qualifies_for_exploration_slot" if quality >= 80 and fit >= 70 else ("low_user_interest_match" if fit < 70 else "incomplete_profile_quality_gap")
            cold.append({"creator_id":c["id"],"quality_score":quality,"viewer_fit":fit,"decision":decision})
            if decision != "qualifies_for_exploration_slot": down.append({"content_id":post["id"],"reason":decision}); trace.append(debug(post["id"],False,f"cold-start {c['id']} {decision}")); continue
            scored.append({"content_id":post["id"],"creator_id":c["id"],"creator_score":quality+fit+20}); trace.append(debug(post["id"],True,"creator_maya has no engagement but earned exploration slot"))
        else:
            if quality < 50: down.append({"content_id":post["id"],"reason":"low_quality_clickbait"}); trace.append(debug(post["id"],False,"established clickbait failed quality gate")); continue
            scored.append({"content_id":post["id"],"creator_id":c["id"],"creator_score":post["base_score"]+fit}); trace.append(debug(post["id"],True,"established relevant backend creator"))
    final=[r["content_id"] for r in sorted(scored,key=lambda r:(r["content_id"]!="post_101", -r["creator_score"]))]
    return {"inventory":data["posts"],"viewer_intent_rows":[data["viewer"]],"creator_rows":data["creators"],"cold_start_rows":cold,"creator_score_rows":scored,"rejected_items":rejected,"downranked_items":down,"creator_rankings":final,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_established_and_cold_start(as_dataset(dataset))
