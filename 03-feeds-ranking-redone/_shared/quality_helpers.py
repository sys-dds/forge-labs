"""Quality-gate helpers used by feeds redone shell scripts."""

from pathlib import Path

CLINIC_FILES = [
    "README.md",
    "00-design.md",
    "00-scenario.md",
    "01-dataset.json",
    "02-broken_simulation.py",
    "03-solution.py",
    "04-proof.tests.py",
    "05-debugging-notes.md",
    "06-break-fix-drills.md",
    "07-interview-explanation.md",
    "08-what-to-notice.md",
    "09-evidence-map.md",
]

CLINIC_DIRS = [
    "01-feed-pipeline-mental-model",
    "02-social-graph-candidate-generation",
    "03-out-of-network-recommendations",
    "04-candidate-mixing-deduplication",
    "05-ranking-signals-feature-rows",
    "06-scoring-models-multi-objective-ranking",
    "07-diversity-exploration-mixing",
    "08-stories-ephemeral-content-snapchat-patterns",
    "09-recommended-notifications",
    "10-feed-evaluation-debugging-simulation",
]


def clinic_paths(root):
    base = Path(root) / "03-feeds-ranking-redone"
    return [base / name for name in CLINIC_DIRS]
