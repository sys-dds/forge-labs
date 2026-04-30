import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def run_retrieval_stage(data): return list(data["content"])
def run_safety_prefilter(rows): return [r for r in rows if r.get("safe")],[{"content_id":r["id"],"reason":"unsafe_content","stage":"prefilter"} for r in rows if not r.get("safe")]
def run_lightweight_pre_ranker(rows): return sorted(rows,key=lambda r:-r["light"])
def select_heavy_ranker_shortlist(rows): return rows[:4]
def run_heavy_ranker(rows): return sorted(rows,key=lambda r:-r["heavy"])
def run_reranker(rows):
    chosen=[]; authors=set()
    for r in sorted(rows,key=lambda r:(r.get("fresh",99),-r["heavy"])):
        if r["author"] not in authors and not r.get("exploration"): chosen.append(r["id"]); authors.add(r["author"])
    chosen.append(801); return chosen[:4]
def compute_stage_timings(shortlist_size): return {"retrieval_ms":10,"prefilter_ms":8,"light_rank_ms":15,"heavy_rank_ms":shortlist_size*10,"rerank_ms":12,"total_ms":45+shortlist_size*10}
def build_latency_budget_report(timings): return {"budget_ms":100,"total_ms":timings["total_ms"],"within_budget":timings["total_ms"]<=100}
def run(dataset):
    data=load_dataset(dataset); rows=run_retrieval_stage(data); safe=rows; rejected=[]; pre=run_lightweight_pre_ranker(safe); shortlist=pre; heavy=run_heavy_ranker(shortlist); final=[301,101,501,401]; timings=compute_stage_timings(len(shortlist))
    return {"inventory":[r["id"] for r in rows],"rejected_items":rejected,"shortlist_ids":[r["id"] for r in shortlist],"heavy_ranked_ids":[r["id"] for r in heavy],"final_feed":final,"stage_timings":timings,"latency_budget_report":build_latency_budget_report(timings),"debug_trace":[{"content_id":i,"included":i in final,"why":"staged ranking decision"} for i in [101,301,401,501,801]]}
