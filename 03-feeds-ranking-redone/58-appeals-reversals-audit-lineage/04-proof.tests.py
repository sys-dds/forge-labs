import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape


def assert_safety_trace(result, item_id, text):
    if not any(row.get("content_id") == item_id and text in row.get("why", "") for row in result.get("safety_debug_trace", [])):
        raise AssertionError(f"expected safety_debug_trace for {item_id} to mention {text}")

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), [], "appeals clinic has no feed handoff")
    assert_equal(result.get("reversal_rows"), [{"case":"case_201","content_id":"post_201","reason":"reversed_stale_report"},{"case":"case_501","content_id":"post_501","reason":"restored_after_creator_evidence"}], "expected exact reversals")
    assert_equal([r["case"] for r in result.get("upheld_rows")], ["case_101", "case_301", "case_401"], "expected upheld cases")
    assert_true(all("original_decision" in row and "final_decision" in row and "evidence_snapshot" in row for row in result.get("audit_log", [])), "audit log must preserve original and final decision")
    assert_true(any(row["case"]=="case_201" and row["reason"]=="stale_report" for row in result.get("audit_log", [])), "post_201 reversal uses stale_report")
    assert_true(any(row["case"]=="case_501" and row["reason"]=="creator_evidence" for row in result.get("audit_log", [])), "post_501 restoration uses creator evidence")
    assert_safety_trace(result, "post_501", "restored_after_creator_evidence")


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
        raise AssertionError("expected broken safety simulation to fail")
    print("PASS feed clinic proof: Appeals reversals audit lineage")

if __name__ == "__main__":
    main()
