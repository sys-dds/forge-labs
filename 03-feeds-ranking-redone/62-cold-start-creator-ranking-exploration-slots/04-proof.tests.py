import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_trace_contains

def check(result):
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present")
    assert_equal(result.get("final_feed"), ["post_101","post_201"], "exact cold-start final feed")
    rows={r["creator_id"]:r["decision"] for r in result.get("cold_start_rows",[])}
    assert_equal(rows,{"creator_maya":"qualifies_for_exploration_slot","creator_lina":"low_user_interest_match","creator_theo":"incomplete_profile_quality_gap"},"exact cold-start rows")
    assert_rejected(result,"post_601","unsafe_creator")
    assert_true({"content_id":"post_301","reason":"low_user_interest_match"} in result.get("downranked_items",[]), "low-fit cold start must be downranked")
    assert_true({"content_id":"post_401","reason":"incomplete_profile_quality_gap"} in result.get("downranked_items",[]), "incomplete profile must be downranked")
    assert_true({"content_id":"post_501","reason":"low_quality_clickbait"} in result.get("downranked_items",[]), "clickbait established creator must be downranked")
    assert_trace_contains(result,"post_201","no engagement")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()
    module = import_module(args.simulation)
    data = load_json(Path(__file__).parent / "01-dataset.json")
    try:
        check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise
    if args.expect_failure:
        raise AssertionError("expected broken ecosystem simulation to fail")
    print("PASS feed clinic proof")

if __name__ == "__main__":
    main()
