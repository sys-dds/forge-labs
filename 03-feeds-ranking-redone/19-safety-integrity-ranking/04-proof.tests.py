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
    assert_equal(result.get("final_feed"), [101,701,501,201], "expected safety final feed [101,701,501,201]")
    assert_rejected(result,301,"blocked_author"); assert_rejected(result,601,"spam_hard_filter")
    assert_equal(result.get("review_queue"), [{"content_id":401,"reason":"review_reported_content"}], "expected review queue for 401")
    assert_equal(result.get("downranked"), [{"content_id":201,"reason":"borderline_clickbait"}], "expected 201 downranked but present")
    assert_debug_trace(result,501); assert_true(result.get("safety_decisions"), "expected safety decisions")


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
