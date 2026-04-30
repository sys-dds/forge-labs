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
    validate_common_result_shape(result); assert_equal(result.get("final_candidate_pool"),[101,201,301,601],"expected popular plus cold-start candidates")
    assert_equal(result.get("cold_start_backfill"),[301,601],"expected cold-start backfill IDs")
    assert_rejected(result,501,"unsafe_new_creator"); assert_rejected(result,401,"low_user_interest_match"); assert_rejected(result,701,"unrelated_popular_item")
    reasons={row["content_id"]:row.get("reason") for row in result.get("retrieved_candidates",[]) if row.get("source")=="cold_start_backfill"}
    assert_equal(reasons,{301:"profile_topic_match_no_engagement",601:"profile_topic_match_no_engagement"},"expected cold-start backfill reasons")
    assert_retrieval_trace(result,301,"no-engagement cold-start"); assert_true(701 not in result.get("final_candidate_pool",[]),"unrelated popular item must not appear")
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected popular-only retrieval to fail")
    print("PASS feed clinic proof: cold-start retrieval")
if __name__=="__main__": main()
