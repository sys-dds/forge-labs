#!/usr/bin/env bash
set -euo pipefail

clinic_paths="$(./scripts/forge-list-sql-redone.sh)"

for clinic_path in $clinic_paths; do
  ./scripts/forge-test-sql-redone.sh "$clinic_path"
done

echo "PASS all SQL redone clinics"
