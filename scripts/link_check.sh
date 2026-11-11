#!/usr/bin/env bash
# Checks the links between this guide's own pages: every relative link in a Markdown file must
# reach a file that exists and, with #anchor, a heading in that file. Web links (http, https,
# mailto) are skipped, because checking them needs the network. Text in fenced code blocks is
# not a link.
#
# Anchors follow GitHub's rule: the heading in lower case, without punctuation other than - and
# _, with spaces as hyphens; a repeated heading gets -1, -2 and so on.
#
# Usage: scripts/link_check.sh [--root DIR]
# Environment: LINK_CHECK_NO_GIT=1 lists files with find instead of git (snapshots and tests)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ "${1:-}" == "--root" ]]; then
    ROOT="$(cd "$2" && pwd)"
fi
cd "$ROOT"

failures=0

#######################################
# Report one broken link and count it.
# Globals:
#   failures
# Arguments:
#   "file:line" of the link.
#   What is wrong.
# Outputs:
#   Writes the problem to stdout.
#######################################
problem() {
    printf '%s: %s\n' "$1" "$2"
    failures=$((failures + 1))
}

#######################################
# List the repo's Markdown files: git's list in a work tree, otherwise every .md file.
# Outputs:
#   Writes one path per line, relative to ROOT, to stdout.
#######################################
markdown_files() {
    if [[ "${LINK_CHECK_NO_GIT:-0}" != 1 ]] \
        && [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == true ]]; then
        git ls-files --cached --others --exclude-standard -- '*.md'
    else
        find . -type f -name '*.md' -not -path './.git/*' -not -path './.check-tmp/*' -printf '%P\n'
    fi
}

#######################################
# Print the GitHub anchor of every heading in a Markdown file, outside code blocks.
# Arguments:
#   Path to the Markdown file.
# Outputs:
#   Writes one anchor per line to stdout.
#######################################
anchors() {
    awk '
        /^[[:space:]]*(```|~~~)/ { fenced = !fenced; next }
        fenced { next }
        /^#+[[:space:]]/ {
            text = $0
            sub(/^#+[[:space:]]+/, "", text)
            sub(/[[:space:]]+#*[[:space:]]*$/, "", text)
            text = tolower(text)
            gsub(/[^a-z0-9 _-]/, "", text)
            gsub(/ /, "-", text)
            if (text in seen) { seen[text]++; text = text "-" seen[text] } else { seen[text] = 0 }
            print text
        }
    ' "$1"
}

#######################################
# Print every link target in a Markdown file with its line number, outside code blocks and
# inline code.
# Arguments:
#   Path to the Markdown file.
# Outputs:
#   Writes "<line> <target>" lines to stdout.
#######################################
links() {
    awk '
        /^[[:space:]]*(```|~~~)/ { fenced = !fenced; next }
        fenced { next }
        {
            line = $0
            gsub(/`[^`]*`/, "", line)
            while (match(line, /\]\([^)[:space:]]+\)/)) {
                print NR, substr(line, RSTART + 2, RLENGTH - 3)
                line = substr(line, RSTART + RLENGTH)
            }
        }
    ' "$1"
}

while IFS= read -r page; do
    dir="$(dirname "$page")"
    while read -r line target; do
        case "$target" in
            http://* | https://* | mailto:*) continue ;;
        esac
        path="${target%%#*}"
        anchor=""
        [[ "$target" != *"#"* ]] || anchor="${target#*#}"
        if [[ -z "$path" ]]; then
            file="$page"
        else
            file="$dir/$path"
            if [[ ! -e "$file" ]]; then
                problem "$page:$line" "$target: no such file"
                continue
            fi
        fi
        if [[ -n "$anchor" && "$file" == *.md ]] \
            && ! anchors "$file" | grep -q -x -F -- "$anchor"; then
            problem "$page:$line" "$target: no such heading"
        fi
    done < <(links "$page")
done < <(markdown_files)

if [[ $failures -gt 0 ]]; then
    printf '%d broken link(s).\n' "$failures" >&2
    exit 1
fi
echo "Link check passed."
