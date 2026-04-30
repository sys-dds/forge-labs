import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_true, assert_rejected
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace

def check(result):
    validate_common_result_shape(result); assert_equal(result.get("final_feed"),[101,401,501,801],"expected reranked latency feed")
    assert_rejected(result,301,"unsafe_content"); assert_true(len(result.get("heavy_ranked_ids",[])) < len(result.get("inventory",[])),"heavy ranker must score shortlist only")
    assert_true(result.get("latency_budget_report",{}).get("within_budget"),"expected latency within 100ms")
    for i in [101,301,401,501,801]: assert_debug_trace(result,i)
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected broken latency pipeline to fail")
    print("PASS feed clinic proof: latency stages")
if __name__=="__main__": main()
