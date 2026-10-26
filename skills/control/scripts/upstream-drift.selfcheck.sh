#!/usr/bin/env bash
# Drift self-check: vendored skills/control/SKILL.md vs the copy bundled in the
# installed herdr binary (`herdr --skill`). Frontmatter is stripped from both
# (the local `name: control` rename is allowed); bodies must match byte for byte.
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

VERSION="$(herdr --version 2>/dev/null </dev/null | awk '{print $NF}' || true)"

if diff -u --label "vendored:skills/control/SKILL.md" --label "herdr --skill (${VERSION:-unknown})" \
    <(strip_frontmatter <"$VENDOR") <(printf '%s\n' "$BUNDLE" | strip_frontmatter); then
    echo "[OK] in sync with herdr ${VERSION:-unknown}"
else
    echo "[DRIFT] update per skills/control/references/upstream.md" >&2
    exit 1
fi
