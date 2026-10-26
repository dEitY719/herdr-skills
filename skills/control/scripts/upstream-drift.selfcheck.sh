#!/usr/bin/env bash
# Drift self-check: vendored skills/control/SKILL.md vs the copy bundled in the
# installed herdr binary (`herdr --skill`). Frontmatter is stripped from both
# (the local `name: control` rename is allowed); bodies must match byte for byte.
# SKILL.md is split into references/*.md; the body is reassembled before comparing.
#
#   bash skills/control/scripts/upstream-drift.selfcheck.sh
#
# Exit 0: in sync, or [SKIP] (no herdr / no --skill). Exit 1: drift, diff printed.
set -euo pipefail

VENDOR="$(cd -- "$(dirname -- "$0")/.." && pwd)/SKILL.md"

if ! command -v herdr >/dev/null 2>&1; then
    echo "[SKIP] herdr not in PATH"
    exit 0
fi

# </dev/null + timeout: an old herdr without --skill may start the TUI instead.
if ! BUNDLE="$(timeout 5 herdr --skill </dev/null 2>/dev/null)" || [ -z "$BUNDLE" ]; then
    echo "[SKIP] herdr --skill unsupported"
    exit 0
fi

# Drop the first `---` ... `---` block when the file opens with one.
strip_frontmatter() {
    awk 'NR == 1 && $0 == "---" { fm = 1; next } fm && $0 == "---" { fm = 0; next } !fm'
}

# Reassemble the upstream body: replace the pointer block (through the
# "Provenance" line) with the four moved sections, in upstream order.
reassemble() {
    local dir; dir="$(dirname -- "$VENDOR")"
    awk -v dir="$dir" '
        /^Read the reference file that matches the job:/ { skip = 1
            n = split("layout-and-agents ids-and-caller-context agent-coordination pane-commands", f, " ")
            for (i = 1; i <= n; i++) {
                path = dir "/references/" f[i] ".md"; ln = 0
                while ((getline line < path) > 0) if (++ln > 2) print line
                close(path); print ""
            }
            next }
        skip && /^Provenance and local changes:/ { skip = 2; next }
        skip == 2 && $0 == "" { skip = 0; next }
        !skip' "$VENDOR"
}

VERSION="$(herdr --version 2>/dev/null </dev/null | awk '{print $NF}' || true)"

if diff -u --label "vendored:skills/control/SKILL.md" --label "herdr --skill (${VERSION:-unknown})" \
    <(reassemble | strip_frontmatter) <(printf '%s\n' "$BUNDLE" | strip_frontmatter); then
    echo "[OK] in sync with herdr ${VERSION:-unknown}"
else
    echo "[DRIFT] update per skills/control/references/upstream.md" >&2
    exit 1
fi
