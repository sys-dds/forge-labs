import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace

def check(result):
    validate_common_result_shape(result); assert_equal(result.get("final_feed"),[104,401,402,901],"expected feedback-loop corrected feed")
    assert_rejected(result,801,"unsafe_content"); assert_true("echo_chamber_risk" in result.get("feedback_loop_report",{}).get("risks",[]),"expected echo_chamber_risk in report")
    for i in [104,401,402,901,801]: assert_debug_trace(result,i)
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected broken feedback loop to fail")
    print("PASS feed clinic proof: feedback loops")
if __name__=="__main__": main()
