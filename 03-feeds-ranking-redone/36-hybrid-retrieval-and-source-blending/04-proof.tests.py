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
    validate_common_result_shape(result)
    assert_equal(result.get("hybrid_candidates"),[101,601,201,301,501],"expected hybrid source blend")
    reasons={row["content_id"]:row["source"] for row in result.get("retrieved_candidates",[])}
    assert_equal(reasons[601],"lexical + semantic","expected 601 to keep both source reasons")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,801,"unsafe_content"); assert_rejected(result,401,"low_relevance_trending")
    assert_retrieval_trace(result,601,"lexical + semantic"); assert_retrieval_trace(result,401,"low_relevance_trending")
    assert_true(501 in result.get("final_candidate_pool",[]),"exploration candidate 501 should survive")
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected trending-only hybrid retrieval to fail")
    print("PASS feed clinic proof: hybrid retrieval")
if __name__=="__main__": main()
