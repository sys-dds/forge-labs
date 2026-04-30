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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("final_feed"),["post_101","listing_501","post_201","listing_601","post_301","listing_901"],"exact capstone final feed")
    assert_equal(result.get("rejected_items"),[{"content_id":"listing_801","reason":"blocked_seller"},{"content_id":"post_1201","reason":"blocked_creator"}],"exact rejected items")
    assert_equal(result.get("risk_suppressed_items"),[{"content_id":"post_401","reason":"low_quality_viral_creator"},{"content_id":"listing_701","reason":"high_marketplace_risk"}],"exact risk suppressed items")
    assert_equal(result.get("missing_ecosystem_explanations"),[{"content_id":"creator_1001","reason":"exposure_budget_exhausted"},{"content_id":"listing_1101","reason":"seller_fully_loaded"}],"exact missing explanations")
    assert_true(result.get("exposure_rows") and result.get("fairness_rows"),"exposure/fairness rows exist")
    assert_true(result.get("buyer_intent_rows"),"buyer intent rows exist")
    assert_true(result.get("seller_quality_rows"),"seller quality rows exist")
    assert_true(result.get("risk_score_rows"),"risk score rows exist")
    design=result.get("ecosystem_system_design",{})
    for key in ["creator_exposure_policy","cold_start_policy","marketplace_intent_policy","seller_quality_policy","supply_demand_policy","marketplace_risk_policy","fairness_policy","debugging_policy","ranking_handoff_contract"]:
        assert_true(isinstance(design.get(key),dict),f"{key} must be rich nested object")
    assert_true(all("candidate_id" in r and "candidate_type" in r and "score_components" in r and "treatments" in r and "traces" in r for r in result.get("ranking_handoff_contract",[])),"handoff must include candidate IDs type score components treatments traces")
    for item in ["post_101","listing_501","post_201","listing_601","post_301","listing_901","listing_801","post_1201","listing_701","creator_1001","listing_1101"]: assert_trace_contains(result,item,item)

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
