import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def apply_hard_filters(rows):
    rejected = []; kept = []
    for row in rows:
        if row["risk"] in {"blocked_author", "malware_link"}:
            rejected.append({"content_id": row["id"], "reason": row["risk"], "stage":"safety_policy"})
        else:
            kept.append(dict(row))
    return kept, rejected

def compute_downrank_penalty(row):
    return {"sensational":25, "engagement_bait_mild":30}.get(row["risk"], 0)

def attach_context_label(row):
    if row["risk"] == "fact_check_context":
        row["context_label"] = "fact_check_context"
    return row

def rank_after_safety_treatments(rows):
    treated = []
    for row in rows:
        item = attach_context_label(dict(row)); item["penalty"] = compute_downrank_penalty(item); item["safety_score"] = item["score"] - item["penalty"]; treated.append(item)
    return sorted(treated, key=lambda row: (-row["safety_score"], row["id"]))

def explain_treatment_order(rows, rejected):
    trace = [{"content_id": r["content_id"], "why": f"hard filter before ranking {r['reason']}"} for r in rejected]
    trace += [{"content_id": row["id"], "why": f"ranked after safety penalty {row['penalty']} label {row.get('context_label','none')}"} for row in rows]
    return trace

def run(dataset):
    data = as_dataset(dataset); kept, rejected = apply_hard_filters(data["candidates"]); ranked = rank_after_safety_treatments(kept)
    downranked = [{"content_id": row["id"], "reason": row["risk"], "penalty": row["penalty"]} for row in ranked if row["penalty"]]
    informed = [{"content_id": row["id"], "reason": row["context_label"]} for row in ranked if "context_label" in row]
    feed = [row["id"] for row in ranked]; trace = explain_treatment_order(ranked, rejected)
    return {"inventory": data["candidates"], "policy_labels": [r["risk"] for r in data["candidates"]], "evidence_rows": ranked, "policy_decisions": ranked, "treatment_rows": ranked, "review_queue": [], "rejected_items": rejected, "downranked_items": downranked, "informed_items": informed, "safe_feed": feed, "final_feed": feed, "audit_log": trace, "safety_debug_trace": trace, "debug_trace": trace}
