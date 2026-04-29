#!/usr/bin/env bash
set -euo pipefail
chapter_paths="$(./scripts/forge-list.sh)"

for chapter_path in $chapter_paths; do
  ./scripts/run-sql-chapter.sh "$chapter_path"
done
echo "PASS all SQL chapters"
