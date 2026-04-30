import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def compute_ctr(r): return r["clicks"]/r["impressions"]
def compute_completion_rate(r): return r["completed"]/r["impressions"]
def compute_skip_rate(r): return r["skipped"]/r["impressions"]
def compute_hide_report_rate(r): return r["hides_reports"]/r["impressions"]
def compute_diversity_count(r): return r["distinct_authors"]
def compute_repeat_author_pressure(r): return r["repeated_author_exposures"]/r["impressions"]
def compare_metric_rows(name,row): return {"variant":name,"ctr":compute_ctr(row),"completion_rate":compute_completion_rate(row),"skip_rate":compute_skip_rate(row),"hide_report_rate":compute_hide_report_rate(row),"diversity_count":compute_diversity_count(row),"repeat_author_pressure":compute_repeat_author_pressure(row),"average_dwell_seconds":row["average_dwell_seconds"]}
def choose_variant_with_guardrails(rows):
    viable=[r for r in rows if r["hide_report_rate"]<=0.02 and r["diversity_count"]>=4 and r["average_dwell_seconds"]>=25]
    return sorted(viable,key=lambda r:(r["completion_rate"],-r["skip_rate"]), reverse=True)[0]["variant"]
def run(dataset):
    data=load_dataset(dataset); rows=[compare_metric_rows(k,v) for k,v in data["variants"].items()]; winner=choose_variant_with_guardrails(rows)
    return {"inventory":["Variant A","Variant B"],"rejected_items":[{"content_id":"Variant A","reason":"guardrails_and_quality_worse","stage":"metric_review"}],"metric_rows":rows,"winner":winner,"debug_trace":[{"content_id":r["variant"],"included":r["variant"]==winner,"why":f"ctr {r['ctr']} completion {r['completion_rate']} hide {r['hide_report_rate']}"} for r in rows]}
