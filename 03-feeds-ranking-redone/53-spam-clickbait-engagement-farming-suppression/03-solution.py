import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


from safety_helpers import safe_divide

def compute_fastback_ratio(row): return round(safe_divide(row["fastbacks"], row["clicks"]), 2)
def detect_engagement_bait_phrase(row): return "comment YES" in row["text"]
def score_source_quality(row): return row["source_quality"]
def classify_spam_pattern(row):
    if "spam scam" in row["text"]: return "spam_scam"
    if score_source_quality(row) < 30: return "low_quality_domain"
    if compute_fastback_ratio(row) >= 0.4: return "clickbait_fastback_ratio"
    if detect_engagement_bait_phrase(row): return "engagement_bait_phrase"
    return "clean"
def apply_spam_suppression(rows):
    evidence=[]; rejected=[]; down=[]; kept=[]
    for row in rows:
        label=classify_spam_pattern(row)
        if label != "clean": evidence.append({"content_id": row["id"], "evidence": label})
        item=dict(row); item["spam_label"]=label
        if label == "spam_scam": rejected.append({"content_id": row["id"], "reason":"spam_scam", "stage":"safety_policy"})
        elif label != "clean": item["penalty"]=100 if label=="low_quality_domain" else 45; down.append({"content_id": row["id"], "reason": {"clickbait_fastback_ratio":"clickbait","engagement_bait_phrase":"engagement_farming","low_quality_domain":"low_quality_domain"}[label]}); kept.append(item)
        else: item["penalty"]=0; kept.append(item)
    return kept,evidence,rejected,down
def rank_with_quality_signals(rows): return [r["id"] for r in sorted(rows, key=lambda r: (-(r["dwell"]+r["likes"]-r["penalty"]), r["id"]))[:5]]
def run(dataset):
    data=as_dataset(dataset); kept,evidence,rejected,down=apply_spam_suppression(data["posts"]); feed=rank_with_quality_signals(kept); trace=[{"content_id": r["id"], "why": f"spam label {r['spam_label']} penalty {r['penalty']}"} for r in kept]+[{"content_id": r["content_id"], "why": r["reason"]} for r in rejected]
    return {"inventory":data["posts"],"policy_labels":[r.get("spam_label") for r in kept],"evidence_rows":evidence,"policy_decisions":kept,"treatment_rows":kept,"review_queue":[],"rejected_items":rejected,"downranked_items":down,"informed_items":[],"safe_feed":feed,"final_feed":feed,"audit_log":trace,"safety_debug_trace":trace,"debug_trace":trace}
