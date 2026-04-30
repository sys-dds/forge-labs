import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def classify_viewer_context(data, viewer): return data["viewers"][viewer]
def classify_content_sensitivity(row): return row["label"]
def decide_contextual_treatment(ctx,row):
    label=row["label"]
    if label=="unsafe_misinformation": return "remove"
    if label=="age_sensitive_graphic" and not ctx["adult"]: return "remove"
    if label=="borderline_medical" and not ctx.get("medical_interest"): return "review"
    if label=="borderline_medical" and ctx.get("medical_interest"): return "inform"
    if label=="sensitive_political" and not ctx["adult"]: return "review"
    if label=="sensitive_political": return "reduce"
    if label=="age_sensitive_graphic": return "reduce"
    return "allow"
def rank_after_contextual_treatment(data, viewer):
    ctx=classify_viewer_context(data,viewer); kept=[]; rejected=[]; informed=[]; down=[]
    for row in data["content"]:
        t=decide_contextual_treatment(ctx,row); item=dict(row); item["treatment"]=t
        if t=="remove": rejected.append({"content_id":row["id"],"reason":row["label"],"stage":"safety_policy"})
        elif t=="review": pass
        else:
            if t=="inform": informed.append({"content_id":row["id"],"reason":"context_label"})
            if t=="reduce": down.append({"content_id":row["id"],"reason":row["label"]}); item["score"]-=40
            kept.append(item)
    return [r["id"] for r in sorted(kept,key=lambda r:-r["score"])[:4]],rejected,informed,down
def explain_contextual_policy(viewer, rejected, informed, down, feed): return [{"content_id":i,"why":f"{viewer} context kept"} for i in feed]+[{"content_id":r["content_id"],"why":f"{viewer} {r['reason']}"} for r in rejected+informed+down]
def run(dataset):
    data=as_dataset(dataset); outputs={}; all_trace=[]
    for viewer in ["Ada","Ben"]:
        feed,rejected,informed,down=rank_after_contextual_treatment(data,viewer); trace=explain_contextual_policy(viewer,rejected,informed,down,feed); all_trace+=trace; outputs[viewer]={"final_feed":feed,"rejected_items":rejected,"informed_items":informed,"downranked_items":down}
    return {"inventory":data["content"],"policy_labels":[r["label"] for r in data["content"]],"evidence_rows":outputs,"policy_decisions":outputs,"treatment_rows":outputs,"review_queue":[],"rejected_items":outputs["Ada"]["rejected_items"],"downranked_items":outputs["Ada"]["downranked_items"],"informed_items":outputs["Ada"]["informed_items"],"viewer_results":outputs,"safe_feed":outputs["Ada"]["final_feed"],"final_feed":outputs["Ada"]["final_feed"],"audit_log":all_trace,"safety_debug_trace":all_trace,"debug_trace":all_trace}
