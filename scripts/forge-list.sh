#!/usr/bin/env bash
set -euo pipefail
find 01-sql -maxdepth 1 -mindepth 1 -type d -name '[0-9][0-9]-*' | sort
