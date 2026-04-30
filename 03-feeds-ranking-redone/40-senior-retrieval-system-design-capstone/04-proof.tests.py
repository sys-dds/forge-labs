import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape

def assert_retrieval_trace(result,item_id,text):
    if not any(row.get("content_id")==item_id and text in row.get("why","") for row in result.get("retrieval_debug_trace",[])):
        raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")
def check(result):
    validate_common_result_shape(result); assert_equal(result.get("final_candidate_pool"),[101,201,301,401,501,601],"expected senior retrieval candidate pool")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,801,"unsafe_content")
    assert_equal(result.get("missing_candidate_explanations"),[{"content_id":901,"reason":"index_not_fresh","stage":"retrieval"},{"content_id":1001,"reason":"ann_bucket_not_probed","stage":"retrieval"}],"expected capstone missing explanations")
    design=result.get("retrieval_system_design",{}); assert_true(isinstance(design.get("source_registry"), list),"source_registry must be rich list")
    assert_true(isinstance(design.get("index_freshness_policy"), dict),"index freshness policy must be nested")
    assert_true(isinstance(design.get("ranking_handoff_contract"), dict),"design handoff contract must be nested")
    handoff=result.get("ranking_handoff_contract",[]); assert_equal([row["content_id"] for row in handoff],[101,201,301,401,501,601],"expected ranking handoff IDs")
    assert_true(all("source" in row and "score" in row and "trace" in row for row in handoff),"handoff must include source score trace")
    for item,text in [(101,"followed_author"),(701,"blocked_author"),(801,"unsafe_content"),(901,"index_not_fresh"),(1001,"ann_bucket_not_probed")]: assert_retrieval_trace(result,item,text)
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected boolean-only retrieval capstone to fail")
    print("PASS feed clinic proof: senior retrieval system design capstone")
if __name__=="__main__": main()
