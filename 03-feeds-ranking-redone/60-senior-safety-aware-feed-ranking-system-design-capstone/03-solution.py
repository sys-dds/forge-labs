import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def build_policy_taxonomy(): return {"remove":["spam_scam","blocked_author"],"reduce":["fake_engagement"],"inform":["borderline_label"],"review":["uncertain_review"],"allow":["safe","trusted_source","appeal_reversed","safe_exploration"]}
def collect_safety_evidence(data): return [{"content_id":r["id"],"evidence":r["risk"],"base_score":r["score"]} for r in data["candidates"]]
def compute_trust_risk_scores(evidence): return [{**r,"risk_score":{"spam_scam":100,"blocked_author":100,"fake_engagement":65,"borderline_label":45,"uncertain_review":70}.get(r["evidence"],10)} for r in evidence]
def apply_treatment_engine(rows):
    kept=[]; rejected=[]; down=[]; informed=[]; restored=[]
    for r in rows:
        item=dict(r); item["treatment"]="allow"; item["rank_score"]=item["base_score"]
        if r["evidence"] in {"spam_scam","blocked_author"}: rejected.append({"content_id":r["content_id"],"reason":r["evidence"],"stage":"safety_policy"}); continue
        if r["evidence"]=="fake_engagement": item["treatment"]="reduce"; item["rank_score"]-=55; down.append({"content_id":r["content_id"],"reason":"fake_engagement_penalty"})
        if r["evidence"]=="borderline_label": item["treatment"]="inform"; informed.append({"content_id":r["content_id"],"reason":"context_label"})
        if r["evidence"]=="appeal_reversed": restored.append({"content_id":r["content_id"],"reason":"appeal_reversal_applied"})
        if r["evidence"]!="uncertain_review": kept.append(item)
    return kept,rejected,down,informed,restored
def build_review_queue(rows): return [{"content_id":r["content_id"],"reason":"uncertain_claim"} for r in rows if r["evidence"]=="uncertain_review"]
def apply_appeal_reversals(rows): return rows
def build_audit_log_policy(): return {"fields":["original_decision","evidence_snapshot","final_decision","reason"]}
def build_safety_incident_response_policy(): return {"regression_checks":["spam_absent","blocked_absent","labels_present","appeals_applied"]}
def build_ranking_handoff_contract(rows): return [{"candidate_id":r["content_id"],"treatment":r["treatment"],"label":r["evidence"],"risk_score":r["risk_score"],"trace":f"{r['content_id']} {r['treatment']} risk {r['risk_score']}"} for r in rows]
def build_safety_system_design(handoff): return {"policy_taxonomy":build_policy_taxonomy(),"evidence_pipeline":{"sources":["content","account","report","graph","engagement"]},"trust_risk_scoring":{"components":["policy","trust","engagement"]},"treatment_engine":{"actions":["hard filter","downrank","label","review"]},"review_queue_policy":{"priority_rules":["severity","reliability"]},"appeal_policy":{"reversal_lineage":True},"audit_log_policy":build_audit_log_policy(),"incident_response_policy":build_safety_incident_response_policy(),"ranking_handoff_contract":{"rows":handoff}}
def run(dataset):
    data=as_dataset(dataset); evidence=collect_safety_evidence(data); scores=compute_trust_risk_scores(evidence); kept,rejected,down,informed,restored=apply_treatment_engine(scores); review=build_review_queue(scores); ranked=sorted(apply_appeal_reversals(kept),key=lambda r:-r["rank_score"]); feed=[r["content_id"] for r in ranked]; handoff=build_ranking_handoff_contract(ranked); design=build_safety_system_design(handoff); trace=[{"content_id":r["candidate_id"],"why":r["trace"]} for r in handoff]+[{"content_id":r["content_id"],"why":r["reason"]} for r in rejected+review+down+informed+restored]
    return {"inventory":data["candidates"],"policy_labels":[r["evidence"] for r in scores],"evidence_rows":evidence,"trust_score_rows":[],"risk_score_rows":scores,"policy_decisions":scores,"treatment_rows":kept,"review_queue":review,"rejected_items":rejected,"downranked_items":down,"informed_items":informed,"restored_items":restored,"safe_feed":feed,"final_feed":feed,"safety_system_design":design,"ranking_handoff_contract":handoff,"audit_log":trace,"safety_debug_trace":trace,"debug_trace":trace}
