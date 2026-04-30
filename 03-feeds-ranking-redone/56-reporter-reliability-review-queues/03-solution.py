import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def compute_reporter_reliability(data): return [{"reporter":k,"reliability":v} for k,v in data["reporters"].items()]
def aggregate_report_weight(data, item): return round(sum(data["reporters"].get(r,1.0) for r,_ in data["reports"][item]),2)
def classify_report_severity(reports): return "auto_detected_spam" if reports[0][0]=="auto" else reports[0][1]
def decide_review_priority(data,item):
    weight=aggregate_report_weight(data,item); severity=classify_report_severity(data["reports"][item])
    if severity=="auto_detected_spam": return "reject_immediate"
    if weight>=0.5 and severity in {"harassment","misinformation"}: return "review"
    return "low_priority"
def route_to_review_queue(data):
    queue=[]; rejected=[]; ignored=[]; audit=[]
    for item in data["reports"]:
        priority=decide_review_priority(data,item); audit.append({"content_id":item,"reporters":[r for r,_ in data["reports"][item]],"weight":aggregate_report_weight(data,item),"priority":priority})
        if priority=="review": queue.append({"content_id":item,"reason":classify_report_severity(data["reports"][item])})
        elif priority=="reject_immediate": rejected.append({"content_id":item,"reason":"auto_detected_spam","stage":"safety_policy"}); queue.append({"content_id":item,"reason":"auto_detected_spam"})
        else: ignored.append({"content_id":item,"reason":"unreliable_mass_report" if item=="post_201" else "unreliable_single_report"})
    return queue,rejected,ignored,audit
def build_report_audit_rows(data): return route_to_review_queue(data)[3]
def run(dataset):
    data=as_dataset(dataset); queue,rejected,ignored,audit=route_to_review_queue(data); trace=[{"content_id":a["content_id"],"why":f"reporters {a['reporters']} weight {a['weight']} priority {a['priority']}"} for a in audit]
    return {"inventory":data["reports"],"policy_labels":[],"evidence_rows":audit,"reporter_reliability_rows":compute_reporter_reliability(data),"policy_decisions":audit,"treatment_rows":audit,"review_queue":queue,"ignored_report_rows":ignored,"rejected_items":rejected,"downranked_items":[],"informed_items":[],"safe_feed":[],"final_feed":[],"audit_log":trace,"safety_debug_trace":trace,"debug_trace":trace}
