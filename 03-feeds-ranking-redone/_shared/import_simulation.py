"""Import a clinic simulation module by filesystem path."""

import importlib.util
from pathlib import Path


def import_simulation(path):
    module_path = Path(path)
    spec = importlib.util.spec_from_file_location("feed_simulation", module_path)
    if spec is None or spec.loader is None:
        raise ImportError(f"could not import simulation from {module_path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    if not hasattr(module, "run"):
        raise AttributeError(f"{module_path} must expose run(dataset: dict) -> dict")
    return module
