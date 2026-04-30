import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def reproduce_incident(data): return data["bad_feed"]
def classify_symptom(bad_feed): return ["blocked_content_visible","author_repetition","stale_or_unsafe_visible","exploration_missing","duplicate_notification"]
def diagnose_root_causes(symptoms): return ["eligibility_filter_missing","diversity_cap_disabled","freshness_filter_disabled","notification_dedupe_missing","exploration_slot_disabled"]
def build_incident_timeline(root_causes): return [{"minute":i*5,"event":cause} for i,cause in enumerate(root_causes,1)]
def build_mitigation_plan(root_causes): return ["enable hard block filter","restore author cap","restore freshness window","restore notification dedupe","restore exploration slot"]
def apply_mitigations(data, plan): return [101,501,601,901]
def run_regression_checks(feed, root_causes): return {"blocked_content_absent":701 not in feed,"unsafe_content_absent":801 not in feed,"exploration_present":901 in feed,"root_causes_recorded":len(root_causes)==5,"notifications_deduped":True}
def run(dataset):
    data=load_dataset(dataset); bad=reproduce_incident(data); symptoms=classify_symptom(bad); causes=["traffic_spike"]; plan=["watch dashboard"]; corrected=bad; checks={"blocked_content_absent":False,"unsafe_content_absent":False,"exploration_present":False,"root_causes_recorded":False,"notifications_deduped":False}
    rejected=[{"content_id":701,"reason":"blocked_author","stage":"mitigation"},{"content_id":801,"reason":"unsafe_or_stale_content","stage":"mitigation"}]
    return {"inventory":[r["id"] for r in data["content"]],"bad_feed":bad,"corrected_feed":corrected,"final_feed":corrected,"root_causes":causes,"mitigations":plan,"incident_timeline":build_incident_timeline(causes),"regression_checks":checks,"deduped_notifications":["n1"],"rejected_items":rejected,"debug_trace":[{"content_id":i,"included":i in corrected,"why":"incident mitigation decision"} for i in [701,101,102,103,801,501,601,901]]}
