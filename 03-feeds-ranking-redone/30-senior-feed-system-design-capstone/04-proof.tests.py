import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace
LAYERS=["candidate_generation_layer","feature_extraction_layer","ranking_layer","reranking_mixing_layer","safety_layer","experiment_layer","event_logging","offline_replay","observability","incident_playbook","out_of_scope"]
def check(result):
    validate_common_result_shape(result); assert_equal(result.get("following_feed"),[101],"expected following surface")
    assert_equal(result.get("for_you_feed"),[101,501,601,901],"expected For You surface"); assert_equal(result.get("stories_tray"),[1101],"expected stories tray")
    assert_equal(result.get("search_results"),[1201],"expected search results"); assert_equal(result.get("notification_candidates"),[1301],"expected notifications")
    assert_equal(result.get("creator_discovery"),["lina","theo"],"expected creator discovery")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,1001,"unsafe_content")
    assert_equal(result.get("missing_explanations"),{"701":"blocked_author","1001":"unsafe_content"},"expected missing explanations")
    assert_true(set(result.get("experiment_guardrails",{}))=={"hide_report_rate","creator_diversity","retention"},"expected experiment guardrails")
    assert_equal(result.get("replay_summary",{}).get("status"),"passed","expected replay summary passed")
    design=result.get("system_design",{}); assert_true(all(layer in design for layer in LAYERS),"expected all system design layers")
    for i in [101,501,601,701,901,1001,1101,1201,1301]: assert_debug_trace(result,i)
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected broken capstone to fail")
    print("PASS feed clinic proof: senior feed design capstone")
if __name__=="__main__": main()
