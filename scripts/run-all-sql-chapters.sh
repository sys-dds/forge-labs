#!/usr/bin/env bash
set -euo pipefail

for chapter_path in 01-sql/[0-9][0-9]-*/; do
  [[ "$chapter_path" == *"_template"* ]] && continue
  ./scripts/run-sql-chapter.sh "${chapter_path%/}"
done

echo "PASS all SQL chapters"
