"""Common result-shape checks with no clinic-specific business rules."""


REQUIRED_KEYS = ("inventory", "rejected_items", "debug_trace")


def validate_common_result_shape(result):
    missing = [key for key in REQUIRED_KEYS if key not in result]
    if missing:
        raise AssertionError(f"result missing required keys {missing}")
    if not isinstance(result.get("rejected_items"), list):
        raise AssertionError("rejected_items must be a list of reason rows")
    if not isinstance(result.get("debug_trace"), list):
        raise AssertionError("debug_trace must be a list of explanation rows")


def final_ids(result):
    return result.get("final_feed", [])
