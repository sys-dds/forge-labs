import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape

def assert_retrieval_trace(result,item_id,text):
    if not any(row.get("content_id")==item_id and text in row.get("why","") for row in result.get("retrieval_debug_trace",[])):
        raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")
def check(result):
    validate_common_result_shape(result); assert_equal(result.get("final_candidate_pool"),[101,201,901],"expected retrieval debug final pool")
    expected=[{"content_id":301,"reason":"index_not_fresh","stage":"retrieval"},{"content_id":401,"reason":"embedding_version_mismatch","stage":"retrieval"},{"content_id":501,"reason":"retrieval_eligibility_filtered","stage":"retrieval"},{"content_id":601,"reason":"source_quota_overflow","stage":"retrieval"},{"content_id":701,"reason":"lexical_tokenization_miss","stage":"retrieval"},{"content_id":801,"reason":"ann_bucket_not_probed","stage":"retrieval"}]
    assert_equal(result.get("missing_candidate_explanations"), expected, "expected exact retrieval missing explanations")
    assert_true(all(row["reason"] != "low_score" for row in result.get("missing_candidate_explanations",[])), "missing candidates must not be called low_score")
    assert_true(all(row["stage"] == "retrieval" for row in result.get("missing_candidate_explanations",[])), "every miss should be retrieval stage")
    for row in expected: assert_retrieval_trace(result,row["content_id"],row["reason"])
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected low-score missing debugger to fail")
    print("PASS feed clinic proof: retrieval missing debugger")
if __name__=="__main__": main()
