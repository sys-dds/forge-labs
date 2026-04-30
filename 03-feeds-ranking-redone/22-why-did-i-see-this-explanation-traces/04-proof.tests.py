import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains
EXPECTED={"101":"Ada follows Ben and affinity is high","501":"Diya liked it and it matches backend topic","601":"Ada shares Backend Club","901":"exploration slot was reserved"}
def check(result):
    validate_common_result_shape(result); assert_equal(result.get("final_feed"), [101,501,601,901], "expected explained final feed")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,801,"unsafe_content")
    assert_equal(result.get("explanations"), EXPECTED, "expected non-generic why-did-I-see-this explanations")
    assert_true(all(v != "recommended for you" for v in result.get("explanations",{}).values()), "generic recommended-for-you explanation is not acceptable")
    for item,text in [(101,"affinity"),(501,"backend topic"),(601,"Backend Club"),(901,"exploration slot")]: assert_debug_trace(result,item); assert_trace_contains(result,item,text)
def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args=parser.parse_args(); data=load_json(Path(__file__).parent/"01-dataset.json"); module=import_module(args.simulation)
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure: print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken explanations to fail")
    print("PASS feed clinic proof: why did I see this")
if __name__=="__main__": main()
