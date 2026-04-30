import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

EXPECTED_FINAL=[101,501,601,701,901]

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected mixed page [101,501,601,701,901]")
    assert_no_duplicates(result.get("final_feed",[]), "expected no duplicate content IDs after mixing")
    assert_equal(result.get("all_reasons",{}).get("501"), ["social_proof","similar_topic","trending"], "expected Lina 501 to preserve social_proof/similar_topic/trending reasons")
    sources={row["content_id"]:row["source"] for row in result.get("candidate_rows",[])}
    assert_equal(sources.get(501), "social_proof", "expected Lina 501 primary reason social_proof")
    assert_equal(result.get("source_quotas"), {"in_network":1,"social_proof":1,"similar_topic":1,"trending":1,"exploration":1}, "expected one item per source quota")
    assert_trace_contains(result,501,"preserved reasons")


def main():
    parser = argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args = parser.parse_args()
    data = load_json(Path(__file__).parent / "01-dataset.json"); module = import_module(args.simulation)
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken simulation to fail the clinic-specific proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__": main()
