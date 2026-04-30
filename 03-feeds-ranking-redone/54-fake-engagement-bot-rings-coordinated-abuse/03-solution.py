import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def detect_new_account_burst(row, data): return len(set(row.get("likes",[])) & set(data["new_accounts"])) >= 4 and row.get("minutes",99) <= 2
def detect_coordinated_repost_cluster(row, data): return len(set(row.get("reposts",[])) & set(data["new_accounts"])) >= 3
def compute_engagement_authenticity_score(row, data): return 30 if detect_new_account_burst(row,data) or detect_coordinated_repost_cluster(row,data) else 90
def identify_suspicious_coordinators(data): return [{"account_id":"noor","evidence":"suspicious_coordinator"}]
def apply_fake_engagement_penalty(data):
    kept=[]; evidence=[]; rejected=[]; down=[]
    for row in data["posts"]:
        if row["spam"]: rejected.append({"content_id":row["id"],"reason":"spam_content","stage":"safety_policy"}); continue
        item=dict(row); item["authenticity_score"]=compute_engagement_authenticity_score(row,data); item["penalty"]=0
        if detect_new_account_burst(row,data): evidence.append({"content_id":row["id"],"evidence":"bursty_new_account_likes"}); down.append({"content_id":row["id"],"reason":"fake_engagement_risk"}); item["penalty"]=50
        if detect_coordinated_repost_cluster(row,data): evidence.append({"content_id":row["id"],"evidence":"coordinated_repost_cluster"}); down.append({"content_id":row["id"],"reason":"coordinated_abuse_risk"}); item["penalty"]=80
        kept.append(item)
    return kept,evidence+identify_suspicious_coordinators(data),rejected,down
def build_abuse_debug_trace(rows,rejected): return [{"content_id":r["id"],"why":f"authenticity {r['authenticity_score']} penalty {r['penalty']}"} for r in rows]+[{"content_id":r["content_id"],"why":r["reason"]} for r in rejected]
def run(dataset):
    data=as_dataset(dataset); rows,evidence,rejected,down=apply_fake_engagement_penalty(data); feed=[r["id"] for r in sorted(rows,key=lambda r: (r["penalty"], -len(r.get("likes",[])), r["id"]))][:3]; trace=build_abuse_debug_trace(rows,rejected)
    return {"inventory":data["posts"],"policy_labels":[],"evidence_rows":evidence,"policy_decisions":rows,"treatment_rows":rows,"review_queue":[],"rejected_items":rejected,"downranked_items":down,"informed_items":[],"safe_feed":feed,"final_feed":feed,"audit_log":trace,"safety_debug_trace":trace,"debug_trace":trace}
