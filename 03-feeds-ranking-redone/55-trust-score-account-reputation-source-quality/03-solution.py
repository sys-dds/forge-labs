import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def compute_account_age_score(row): return min(30, row["age"]//30)
def compute_report_history_score(row): return max(0, 35-row["reports"]*3)
def compute_source_quality_score(row): return row["editorial_quality"]//2
def compute_trust_score(row): return compute_account_age_score(row)+compute_report_history_score(row)+compute_source_quality_score(row)
def apply_trust_safety_decisions(data):
    rows=[]; rejected=[]; down=[]
    for a in data["authors"]:
        score=compute_trust_score(a); item={"author":a["name"],"content_id":a["post"],"trust_score":score,"source_quality":a["source"],"followers":a["followers"]}
        if a["reports"]>=20: rejected.append({"content_id":a["post"],"reason":"author_prior_violations","stage":"safety_policy"})
        elif a["source"]<30: down.append({"content_id":a["post"],"reason":"low_source_quality"}); item["penalty"]=40; rows.append(item)
        else: item["penalty"]=0; rows.append(item)
    return rows,rejected,down
def rank_with_trust_score(rows): return [r["content_id"] for r in sorted(rows,key=lambda r:(-(r["trust_score"]-r["penalty"]), r["content_id"]))[:5]]
def run(dataset):
    data=as_dataset(dataset); rows,rejected,down=apply_trust_safety_decisions(data); feed=rank_with_trust_score(rows); trace=[{"content_id":r["content_id"],"why":f"trust_score {r['trust_score']} source {r['source_quality']}"} for r in rows]+[{"content_id":r["content_id"],"why":r["reason"]} for r in rejected]
    return {"inventory":data["authors"],"policy_labels":[],"evidence_rows":rows,"trust_score_rows":rows,"risk_score_rows":[{"content_id":r["content_id"],"risk_score":100-r["trust_score"]} for r in rows],"policy_decisions":rows,"treatment_rows":rows,"review_queue":[],"rejected_items":rejected,"downranked_items":down,"informed_items":[],"safe_feed":feed,"final_feed":feed,"audit_log":trace,"safety_debug_trace":trace,"debug_trace":trace}
