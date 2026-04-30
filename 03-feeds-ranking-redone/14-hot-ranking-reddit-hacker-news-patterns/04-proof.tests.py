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
    assert_equal(result.get("hot_ranked_posts"), [401,101,501,701,601,201], "expected hot ranked posts [401,101,501,701,601,201]")
    assert_rejected(result,301,"removed_by_moderation")
    scores={r["content_id"]:r["score_components"] for r in result.get("score_rows",[])}
    assert_true(scores[201]["age_hours"] > scores[101]["age_hours"], "expected Cy 201 age decay to be visible")
    assert_true(scores[601]["controversy_penalty"] > 0, "expected Omar 601 controversy penalty")
    assert_true(result.get("math_breakdown"), "expected math breakdown for hot ranking")
    assert_debug_trace(result,401)


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
