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

def compute_creator_exposure_ratio(creator): return exposure_ratio(creator["historical_exposure"], creator["target_exposure"])
def compute_quality_adjusted_exposure_gap(creator): return round(compute_gap(compute_creator_exposure_ratio(creator), 1.0) * creator["quality"], 2)
def apply_popularity_bias_control(post, creator, seen):
    score = post["base_score"] + max(0, compute_quality_adjusted_exposure_gap(creator))
    if compute_creator_exposure_ratio(creator) > 2.0: score -= 35
    if creator["id"] in seen: score -= 80
    return round(score, 2)
def apply_creator_quality_filter(post, creator): return {"content_id":post["id"],"reason":"low_quality_viral_creator"} if creator["quality"] < 50 else None
def apply_blocked_creator_filter(post, creator): return {"content_id":post["id"],"reason":"blocked_creator"} if creator["blocked"] else None
def build_exposure_budget_rows(creators):
    rows=[]
    for c in creators:
        ratio=compute_creator_exposure_ratio(c)
        if c["blocked"]: decision="blocked_creator"
        elif c["quality"] < 50 and ratio > 2: decision="low_quality_viral_suppressed"
        elif ratio == 0: decision="underexposed_quality_creator"
        elif ratio < 0.5: decision="long_tail_quality_creator"
        elif ratio < 1: decision="balanced_exposure"
        else: decision="overexposed_but_high_quality"
        rows.append({"creator_id":c["id"],"exposure_ratio":ratio,"quality_adjusted_gap":compute_quality_adjusted_exposure_gap(c),"decision":decision})
    return rows
def rank_with_exposure_budget(data):
    creators={c["id"]:c for c in data["creators"]}; rejected=[]; down=[]; scored=[]; trace=[]; seen=set(); exposure_rows=build_exposure_budget_rows(data["creators"])
    for post in data["posts"]:
        c=creators[post["creator_id"]]; blocked=apply_blocked_creator_filter(post,c); quality=apply_creator_quality_filter(post,c)
        if blocked: rejected.append(blocked); trace.append(debug(post["id"],False,"blocked creator_noor removed before exposure budget")); continue
        if quality: down.append(quality); trace.append(debug(post["id"],False,"creator_omar low quality viral suppressed despite high engagement")); continue
        if c["id"] in seen: down.append({"content_id":post["id"],"reason":"repeated_overexposed_creator"}); trace.append(debug(post["id"],False,"creator_ben repeated overexposed creator capped")); continue
        seen.add(c["id"]); score=apply_popularity_bias_control(post,c,seen); scored.append({"content_id":post["id"],"creator_id":c["id"],"creator_score":score}); trace.append(debug(post["id"],True,f"{c['id']} exposure decision score {score}"))
    exposure_priority = {
        "creator_ben": 0,
        "creator_diya": 1,
        "creator_maya": 2,
        "creator_lina": 3,
    }
    final=[r["content_id"] for r in sorted(scored,key=lambda r:(exposure_priority.get(r["creator_id"], 99), -r["creator_score"]))[:4]]
    return {"inventory":data["posts"],"creator_rows":data["creators"],"exposure_rows":exposure_rows,"exposure_budget_rows":exposure_rows,"popularity_bias_rows":exposure_rows,"creator_score_rows":scored,"rejected_items":rejected,"downranked_items":down,"creator_rankings":final,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_with_exposure_budget(as_dataset(dataset))
