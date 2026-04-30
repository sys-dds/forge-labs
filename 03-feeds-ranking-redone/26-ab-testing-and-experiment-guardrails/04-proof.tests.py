import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_true, assert_rejected
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

def check(result):
    validate_common_result_shape(result); assert_equal(result.get("launch_decision"),"do_not_launch","expected treatment not to launch")
    assert_equal(result.get("guardrail_failures"),["hide_report_rate","creator_diversity","retention"],"expected exact guardrail failures")
    assert_true(result.get("experiment_delta",{}).get("ctr")>0,"treatment should improve CTR but still fail")
    assert_rejected(result,"treatment","guardrail_failures"); assert_debug_trace(result,"treatment"); assert_trace_contains(result,"treatment","failures")
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected CTR-only launch to fail")
    print("PASS feed clinic proof: experiment guardrails")
if __name__=="__main__": main()
