#!/usr/bin/env bash
# growth - install script
# Usage: ./install.sh <platform>
#   platforms: codex
#
# Claude Code users: install via the plugin marketplace instead of this script.
#   /plugin marketplace add wzg7014/growth
#   /plugin install growth@growth
# See https://code.claude.com/docs/en/plugin-marketplaces

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLATFORM="${1:-}"

if [[ -z "$PLATFORM" ]]; then
  cat <<EOF
growth — 思考训练 skill 集合

Usage: ./install.sh <platform>

Platforms:
  codex            Install to ~/.codex/skills/

For Claude Code, use the plugin marketplace instead:
  /plugin marketplace add wzg7014/growth
  /plugin install growth@growth

Example:
  ./install.sh codex
EOF
  exit 1
fi

copy_skills_to() {
  local dst="$1"
  mkdir -p "$dst"
  for skill in taste-audit intent-refine judgment-redteam abstraction-uplift; do
    cp -r "$SCRIPT_DIR/skills/$skill" "$dst/"
    echo "  ✓ installed: $skill"
  done
}

case "$PLATFORM" in
  claude-code)
    cat <<EOF
✗ Claude Code no longer uses this script.

Install via the official plugin marketplace instead:
  /plugin marketplace add wzg7014/growth
  /plugin install growth@growth

Docs: https://code.claude.com/docs/en/plugin-marketplaces
EOF
    exit 1
    ;;

  codex)
    DST="$HOME/.codex/skills"
    echo "Installing growth skills to $DST ..."
    copy_skills_to "$DST"
    echo ""
    echo "✓ Done. Restart Codex CLI to load the new skills."
    ;;

  *)
    echo "✗ Unknown platform: $PLATFORM"
    echo "Run './install.sh' without arguments to see usage."
    exit 1
    ;;
esac
