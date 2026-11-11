#!/usr/bin/env bash
# Every gate, in order. The git hooks and CI run exactly this; run it yourself before pushing.
#
#   1. tools      shellcheck is installed
#   2. hygiene    whitespace, final newline, line endings, conflict markers, file size
#   3. privacy    no personal or machine details, no secrets (scripts/privacy_scan.sh)
#   4. links      every link between the guide's pages reaches a real file and heading
#   5. shellcheck every script and hook
#   6. self-tests the check scripts' own tests
#
# Usage: scripts/check.sh
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

#######################################
# Print a step heading.
# Arguments:
#   The step's name.
# Outputs:
#   Writes "==> <name>" to stdout.
#######################################
step() { printf '\n==> %s\n' "$*"; }

step "tools"
if ! command -v shellcheck >/dev/null 2>&1; then
    echo "missing tool: shellcheck (install it with the system package manager)" >&2
    exit 1
fi
echo "shellcheck found."

step "hygiene"
scripts/hygiene_check.sh

step "privacy and secret scan"
scripts/privacy_scan.sh

step "links between pages"
scripts/link_check.sh

step "shellcheck"
shellcheck --severity=style scripts/*.sh .githooks/*
echo "shellcheck passed."

step "check-script self-tests"
# On success print the last line; on failure print every FAIL line, so CI and the hooks name
# the broken checks instead of only the count.
for test in scripts/*_test.sh; do
    printf '%s: ' "$test"
    if out="$("$test" 2>&1)"; then
        tail -n 1 <<<"$out"
    else
        echo "failed"
        grep -E '^FAIL' <<<"$out" || printf '%s\n' "$out"
        exit 1
    fi
done

printf '\nAll checks passed.\n'
