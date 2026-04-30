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
    assert_equal(result.get("home_recommendations"), [301,401,901,201], "expected Home recommendations [301,401,901,201]")
    assert_equal(result.get("up_next"), [201,801,901], "expected Up Next [201,801,901]")
    assert_true(result.get("home_recommendations") != result.get("up_next"), "expected Home and Up Next to differ")
    assert_rejected(result,501,"clickbait_abandonment"); assert_rejected(result,601,"blocked_author"); assert_rejected(result,701,"no_home_or_session_relevance")
    assert_debug_trace(result,301); assert_debug_trace(result,"up_next:201"); assert_trace_contains(result,"up_next:801","101")


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
