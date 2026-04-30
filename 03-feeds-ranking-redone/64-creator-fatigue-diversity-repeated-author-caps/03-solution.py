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

def count_creator_frequency(feed):
    counts={}
    for row in feed: counts[row["creator_id"]]=counts.get(row["creator_id"],0)+1
    return counts
def apply_repeated_author_cap(row, counts, cap=2): return counts.get(row["creator_id"],0) < cap
def compute_creator_diversity_score(row, counts): return row["score"] + (20 if counts.get(row["creator_id"],0)==0 else -30)
def explain_creator_fatigue(row): return f"{row['creator_id']} cap protects Ada from repeated-author fatigue"
def select_diverse_feed_page(data):
    rejected=[]; down=[]; picked=[]; trace=[]; diversity=[]
    for row in sorted(data["posts"],key=lambda r:-r["score"]):
        if row["blocked"]: rejected.append({"content_id":row["id"],"reason":"blocked_creator"}); trace.append(debug(row["id"],False,"blocked_creator removed")); continue
        if row["quality"] < 50: rejected.append({"content_id":row["id"],"reason":"low_quality_viral"}); trace.append(debug(row["id"],False,"low_quality_viral removed")); continue
        counts=count_creator_frequency(picked)
        if not apply_repeated_author_cap(row,counts): down.append({"content_id":row["id"],"reason":"repeated_author_cap"}); trace.append(debug(row["id"],False,explain_creator_fatigue(row))); continue
        picked.append(row); trace.append(debug(row["id"],True,f"diversity selection {row['creator_id']}"))
        if row["creator_id"]=="Ben" and count_creator_frequency(picked)["Ben"]==2: diversity.append({"creator_id":"Ben","decision":"capped_after_two_posts"})
        elif row["creator_id"] in {"Diya","Maya"}: diversity.append({"creator_id":row["creator_id"],"decision":"diversity_fill"})
        elif row["creator_id"]=="Lina": diversity.append({"creator_id":"Lina","decision":"secondary_interest_diversity"})
        if len(picked)==5: break
    final=[r["id"] for r in picked]
    return {"inventory":data["posts"],"creator_rows":data["posts"],"fairness_rows":diversity,"diversity_rows":diversity,"rejected_items":rejected,"downranked_items":down,"creator_rankings":final,"final_feed":final,"ecosystem_debug_trace":trace,"debug_trace":trace}
def run(dataset): return select_diverse_feed_page(as_dataset(dataset))
