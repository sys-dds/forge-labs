"""Small assertion helpers with messages that name the expected feed behavior."""


def assert_equal(actual, expected, message):
    if actual != expected:
        raise AssertionError(f"{message}; got {actual}")


def assert_true(condition, message):
    if not condition:
        raise AssertionError(message)


def ids_from_rejections(rejected_items):
    if isinstance(rejected_items, dict):
        return {str(key): value for key, value in rejected_items.items()}
    return {str(row.get("content_id")): row.get("reason") for row in rejected_items}


def trace_ids(debug_trace):
    if isinstance(debug_trace, dict):
        return {str(key) for key in debug_trace}
    return {str(row.get("content_id")) for row in debug_trace}
