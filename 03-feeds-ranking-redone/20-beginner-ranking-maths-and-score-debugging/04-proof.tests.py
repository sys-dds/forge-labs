import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), [601,301,201,401,101], "expected beginner ranking maths final feed [601,301,201,401,101]")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,501,"high_report_penalty_or_suppressed")
    components={r["content_id"]:r["score_components"] for r in result.get("score_rows",[])}
    assert_equal(components[101]["normalised_engagement"], 10.0, "expected Ben 101 normalised engagement 10.0")
    assert_equal(components[301]["affinity_boost"], 25, "expected Diya 301 affinity boost 25")
    assert_equal(components[401]["exploration_boost"], 25, "expected Lina 401 exploration boost 25")
    assert_equal(components[601]["completion_boost"], 35, "expected Maya 601 completion boost 35")
    assert_true(result.get("math_breakdown"), "expected math breakdown rows")
    for item_id in [601,301,201,401,101]: assert_debug_trace(result,item_id)


def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args=parser.parse_args()
    dataset=load_json(Path(__file__).parent / "01-dataset.json"); module=import_module(args.simulation)
    try: check(module.run(dataset))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken simulation to fail the product-surface proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__": main()
