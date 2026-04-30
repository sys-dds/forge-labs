import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def collect_followed_candidates(items): return [row for row in items if "followed_author" in row["sources"]]
def collect_lexical_candidates(items): return [row for row in items if "lexical" in row["sources"]]
def collect_semantic_candidates(items): return [row for row in items if "semantic" in row["sources"]]
def collect_trending_candidates(items): return [row for row in items if "trending" in row["sources"]]
def collect_exploration_candidates(items): return [row for row in items if "exploration" in row["sources"]]
def merge_sources_with_reasons(source_rows):
    merged = {}
    for row in source_rows:
        merged.setdefault(row["id"], {"content_id": row["id"], "sources": [], "relevance": row.get("relevance", 0), "row": row})
        for source in row["sources"]:
            if source not in merged[row["id"]]["sources"]:
                merged[row["id"]]["sources"].append(source)
    return list(merged.values())
def apply_source_quotas(rows):
    selected=[]; rejected=[]
    priority={"followed_author":1,"lexical":2,"semantic":3,"exploration":4,"trending":5}
    for row in rows:
        raw=row["row"]
        if raw.get("blocked"):
            rejected.append({"content_id":row["content_id"],"reason":"blocked_author","stage":"retrieval_eligibility"})
        elif raw.get("unsafe"):
            rejected.append({"content_id":row["content_id"],"reason":"unsafe_content","stage":"retrieval_eligibility"})
        elif row["sources"] == ["trending"] and row["relevance"] < 0.5:
            rejected.append({"content_id":row["content_id"],"reason":"low_relevance_trending","stage":"source_blending"})
        else:
            selected.append(row)
    selected.sort(key=lambda row:(min(priority[source] for source in row["sources"]), -len(row["sources"]), row["content_id"]))
    return selected, rejected
def build_hybrid_pool(data):
    items=data["items"]
    rows=[]
    for fn in [collect_followed_candidates, collect_lexical_candidates, collect_semantic_candidates, collect_trending_candidates, collect_exploration_candidates]:
        rows.extend(fn(items))
    return apply_source_quotas(merge_sources_with_reasons(rows))
def run(dataset_path):
    data=load_dataset(dataset_path); selected,rejected=build_hybrid_pool(data)
    candidates=[{"content_id":row["content_id"],"source":" + ".join(row["sources"])} for row in selected]
    ids=[row["content_id"] for row in candidates]
    trace=[]
    for item in data["items"]:
        reason=next((row["reason"] for row in rejected if row["content_id"]==item["id"]), None)
        why=reason if reason else " + ".join(next(row["sources"] for row in selected if row["content_id"]==item["id"]))
        trace.append({"content_id":item["id"],"included":item["id"] in ids,"why":f"{item['id']} {why}"})
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["followed_author","lexical","semantic","trending","exploration"],"hybrid_candidates":ids,"retrieved_candidates":candidates,"final_candidate_pool":ids,"missed_candidates":[],"rejected_items":rejected,"retrieval_debug_trace":trace,"debug_trace":trace}
