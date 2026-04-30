import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

EXPECTED_FINAL=[101,401,501]

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected social graph candidates [101,401,501]")
    assert_no_duplicates(result.get("final_feed", []), "expected no duplicate social graph candidate IDs")
    sources={row["content_id"]:row["source"] for row in result.get("candidate_rows",[])}
    assert_equal(sources.get(101), "close_friend", "expected candidate 101 source close_friend")
    assert_equal(sources.get(401), "shared_group", "expected candidate 401 source shared_group")
    assert_equal(sources.get(501), "commented_by_following", "expected candidate 501 source commented_by_following")
    assert_rejected(result,201,"muted_author"); assert_rejected(result,301,"blocked_author"); assert_rejected(result,601,"no_social_path")
    for item_id in EXPECTED_FINAL: assert_debug_trace(result,item_id)
    assert_trace_contains(result,501,"Maya")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()
    data = load_json(Path(__file__).parent / "01-dataset.json")
    module = import_module(args.simulation)
    try:
        check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise
    if args.expect_failure:
        raise AssertionError("expected broken simulation to fail the clinic-specific proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__": main()
