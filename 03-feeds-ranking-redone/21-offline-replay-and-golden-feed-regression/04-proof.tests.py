import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("golden_feed"), [101,501,601,901], "expected golden feed replay order")
    assert_equal(result.get("actual_feed"), [101,501,601,901], "expected actual replay feed to match golden")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,801,"unsafe_content")
    assert_equal(result.get("regression_report"), [], "expected no golden-feed regression rows")
    assert_equal(result.get("replay_summary",{}).get("status"), "passed", "expected replay summary passed")
    for item in [101,501,601,701,801,901]: assert_debug_trace(result,item)
    assert_trace_contains(result,901,"survived replay eligibility")

def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args=parser.parse_args(); module=import_module(args.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure: print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken simulation to fail replay regression proof")
    print("PASS feed clinic proof: offline replay and golden feed regression")
if __name__=="__main__": main()
