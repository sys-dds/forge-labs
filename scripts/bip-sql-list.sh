#!/usr/bin/env bash
set -euo pipefail
find 04-backend-interview-patterns-redone/01-sql-interview-patterns -maxdepth 1 -type d -name '[0-9][0-9][0-9]-*' | sort
