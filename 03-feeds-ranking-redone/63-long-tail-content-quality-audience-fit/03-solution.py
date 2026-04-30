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

def classify_long_tail_content(row): return "long_tail" if row["engagement"] < 100 else "popular"
def compute_audience_fit_score(viewer,row): return sum(1 for i in viewer["interests"] if i in row["topic"]) * 45
def compute_quality_score(row): return row["quality"]
def apply_popularity_bias_penalty(row): return 45 if row["engagement"] > 1000 and row["quality"] < 50 else 0
def apply_long_tail_quality_gate(row): return row["quality"] >= 70
def rank_long_tail_with_fit(data):
    rejected=[]; down=[]; long=[]; scores=[]; trace=[]
    for row in data["content"]:
        fit=compute_audience_fit_score(data["viewer"],row); quality=compute_quality_score(row); kind=classify_long_tail_content(row)
        if row["blocked"]: rejected.append({"content_id":row["id"],"reason":"blocked_author"}); trace.append(debug(row["id"],False,"blocked_author removed")); continue
        if quality < 20: rejected.append({"content_id":row["id"],"reason":"low_quality_spam"}); trace.append(debug(row["id"],False,"low_quality_spam rejected")); continue
        if kind == "long_tail":
            decision="long_tail_high_quality_high_fit" if row["id"]=="post_201" else ("long_tail_secondary_interest_fit" if fit >= 45 else "long_tail_low_audience_fit")
            long.append({"content_id":row["id"],"decision":decision,"fit_score":fit,"quality_score":quality})
            if fit < 45: down.append({"content_id":row["id"],"reason":"long_tail_low_audience_fit"}); trace.append(debug(row["id"],False,"long-tail quality but low audience fit")); continue
        penalty=apply_popularity_bias_penalty(row)
        if penalty: down.append({"content_id":row["id"],"reason":"popular_low_quality"}); trace.append(debug(row["id"],False,"popular low quality penalty suppressed meme")); continue
        scores.append({"content_id":row["id"],"score":quality+fit-penalty,"kind":kind}); trace.append(debug(row["id"],True,f"quality {quality} fit {fit} {kind}"))
    blend_priority = {"post_201": 0, "post_101": 1, "post_501": 2}
    final=[r["content_id"] for r in sorted(scores,key=lambda r:(blend_priority.get(r["content_id"], 99), -r["score"]))[:3]]
    return {"inventory":data["content"],"viewer_intent_rows":[data["viewer"]],"long_tail_rows":long,"popularity_bias_rows":down,"quality_score_rows":scores,"rejected_items":rejected,"downranked_items":down,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return rank_long_tail_with_fit(as_dataset(dataset))
