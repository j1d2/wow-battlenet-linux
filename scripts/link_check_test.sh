#!/usr/bin/env bash
# Offline checks for scripts/link_check.sh: links between the guide's pages must reach a real
# file and, with #anchor, a real heading. Fixtures live in .check-tmp/ (git ignores it), removed
# on exit.
#
# Usage: scripts/link_check_test.sh
# No -e: each check reports its own result, and a failed one must not stop the rest.
set -uo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit 1

readonly ROOT="$PWD/.check-tmp/link-test"
failed=0

cleanup() { [[ ! -d "$PWD/.check-tmp" ]] || rm -r "$PWD/.check-tmp"; }
trap cleanup EXIT

#######################################
# Record one result.
# Globals:
#   failed (counts failures)
# Arguments:
#   Check name.
#   0 if it passed, anything else if it failed.
# Outputs:
#   Writes "ok  <name>" or "FAIL  <name>" to stdout.
#######################################
check() {
    if [[ "$2" -eq 0 ]]; then
        printf 'ok  %s\n' "$1"
    else
        printf 'FAIL  %s\n' "$1"
        failed=$((failed + 1))
    fi
}

#######################################
# Build a small guide whose links all work: a README and two pages in docs/, with headings
# that have punctuation and a repeated heading.
# Globals:
#   ROOT
#######################################
good_guide() {
    [[ ! -d "$ROOT" ]] || rm -r "$ROOT"
    mkdir -p "$ROOT/docs"
    printf 'license\n' >"$ROOT/LICENSE"
    cat >"$ROOT/README.md" <<'EOF'
# Guide

## TL;DR

See [Arch](docs/arch.md), [its steps](docs/arch.md#install-dxvk-first),
[Pop](docs/ubuntu.md#ubuntu-linux-mint-and-pop_os) and [below](#wrong-python-on-path).
[![Badge](https://img.shields.io/badge/x-y-blue)](LICENSE) and [site](https://lutris.net).

## Wrong Python on PATH

Text.

## Notes

## Notes

[Second notes](#notes-1)

```bash
echo "[not a link](missing.md)"
```
EOF
    cat >"$ROOT/docs/arch.md" <<'EOF'
# Arch Linux

## Install DXVK first

Back to the [README](../README.md#tldr).
EOF
    cat >"$ROOT/docs/ubuntu.md" <<'EOF'
# Ubuntu

## Ubuntu, Linux Mint, and Pop!_OS

[Top](#ubuntu)
EOF
}

#######################################
# Run the link check on the fixture.
# Globals:
#   ROOT
#   out, status (set to the check's output and exit status)
#######################################
run_check() {
    out="$(LINK_CHECK_NO_GIT=1 scripts/link_check.sh --root "$ROOT" 2>&1)"
    status=$?
}

good_guide
run_check
check "a guide whose links all work passes" "$status"

good_guide
printf '\n[Gone](docs/fedora.md)\n' >>"$ROOT/README.md"
run_check
if [[ $status -eq 1 && "$out" == *"README.md:"*"docs/fedora.md: no such file"* ]]; then rc=0; else rc=1; fi
check "a link to a missing file is caught, with its line" "$rc"

good_guide
printf '\n[Gone](docs/arch.md#what-you-need)\n' >>"$ROOT/README.md"
run_check
if [[ $status -eq 1 && "$out" == *"docs/arch.md#what-you-need: no such heading"* ]]; then rc=0; else rc=1; fi
check "a link to a missing heading in another page is caught" "$rc"

good_guide
printf '\n[Gone](#audio)\n' >>"$ROOT/README.md"
run_check
if [[ $status -eq 1 && "$out" == *"#audio: no such heading"* ]]; then rc=0; else rc=1; fi
check "a link to a missing heading on the same page is caught" "$rc"

good_guide
printf '\n[Back](../README.md#nope)\n' >>"$ROOT/docs/arch.md"
run_check
if [[ $status -eq 1 && "$out" == *"docs/arch.md:"*"../README.md#nope: no such heading"* ]]; then rc=0; else rc=1; fi
check "links are resolved from the page's own folder" "$rc"

good_guide
if [[ "$out" != *"missing.md"* ]]; then rc=0; else rc=1; fi
check "text inside a code block is not a link" "$rc"

if [[ $failed -gt 0 ]]; then
    printf '%d link test(s) failed.\n' "$failed" >&2
    exit 1
fi
echo "all passed"
