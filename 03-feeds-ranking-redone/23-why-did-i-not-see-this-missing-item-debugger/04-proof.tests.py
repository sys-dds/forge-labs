import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains
EXPECTED={"201":"rejected_muted_author","301":"rejected_blocked_author","401":"eligible_but_below_score_cutoff","501":"removed_by_diversity_cap","601":"not_retrieved_no_candidate_source","701":"already_seen","801":"stale_outside_freshness_window"}
def check(result):
    validate_common_result_shape(result); assert_equal(result.get("final_feed"),[101,901],"expected missing-debugger final feed")
    assert_equal(result.get("missing_explanations"),EXPECTED,"expected stage-specific missing explanations")
    assert_true(set(result.get("missing_explanations",{}).values()) != {"low_score"}, "missing debugger must not call every item low_score")
    for item,reason in EXPECTED.items(): assert_debug_trace(result,int(item)); assert_trace_contains(result,int(item),reason)
def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure",action="store_true"); parser.add_argument("--expect-success",action="store_true"); args=parser.parse_args(); module=import_module(args.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure: print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken missing-item debugger to fail")
    print("PASS feed clinic proof: missing item debugger")
if __name__=="__main__": main()
