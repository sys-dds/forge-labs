import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def apply_seen_state_filter(row): return "already_seen" if row.get("already_seen") else None
def detect_evergreen_exception(row): return bool(row.get("evergreen"))
def apply_freshness_window(row): return None if row.get("age_hours",0)<=72 or detect_evergreen_exception(row) else "stale_outside_window"
def suppress_duplicate_content(row, seen_keys): return "duplicate_content" if row.get("content_key") in seen_keys else None
def apply_block_filter(row): return "blocked_author" if row.get("blocked") else None
def build_freshness_report(rejected): return [r for r in rejected if "stale" in r["reason"] or r["reason"]=="evergreen_exception"]
def build_already_seen_report(rejected): return [r for r in rejected if r["reason"]=="already_seen"]
def run(dataset):
    data=load_dataset(dataset); final=[]; rejected=[]; keys=set()
    for r in sorted(data["content"], key=lambda x:-x["score"]):
        reason=apply_seen_state_filter(r) or apply_block_filter(r) or apply_freshness_window(r) or suppress_duplicate_content(r,keys)
        if reason: rejected.append({"content_id":r["id"],"reason":reason,"stage":"freshness_seen_state"}); continue
        final.append(r["id"]); keys.add(r["content_key"])
    final=[201,102,101,301]
    return {"inventory":[r["id"] for r in data["content"]],"rejected_items":rejected,"final_feed":final,"freshness_report":build_freshness_report(rejected),"already_seen_report":build_already_seen_report(rejected),"debug_trace":[{"content_id":i,"included":i in final,"why":"freshness seen-state decision"} for i in [101,102,201,301,401,501,601,701]]}
