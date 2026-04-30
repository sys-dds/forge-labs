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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("final_feed"),["post_101","listing_201","creator_maya"],"exact debugging final feed")
    expected={"post_301":("repeated_author_cap","ecosystem_diversity"),"creator_lina":("exposure_budget_exhausted","exposure_budget"),"listing_401":("seller_fully_loaded","supply_capacity"),"listing_501":("fraud_risk_suppressed","marketplace_risk"),"post_601":("low_audience_fit","relevance"),"creator_omar":("low_quality_viral_suppressed","quality_gate"),"listing_701":("wrong_category","buyer_intent"),"post_801":("blocked_creator","safety_eligibility")}
    actual={r["content_id"]:(r["reason"],r.get("stage")) for r in result.get("missing_ecosystem_explanations",[])}
    assert_equal(actual,expected,"exact missing ecosystem explanations")
    assert_true(all(r["reason"]!="low_score" for r in result.get("missing_ecosystem_explanations",[])),"no missing explanation says low_score")
    assert_true(all(r.get("stage") for r in result.get("missing_ecosystem_explanations",[])),"every missing explanation has stage")
    assert_trace_contains(result,"listing_501","marketplace_risk")

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
