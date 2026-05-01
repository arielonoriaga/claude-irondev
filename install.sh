#!/usr/bin/env bash
set -e

SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

git clone --depth 1 https://github.com/arielonoriaga/claude-irondev "$TMP/repo" 2>/dev/null

mkdir -p "$SKILLS_DIR"
cp -r "$TMP/repo/irondev" "$TMP/repo/irondev-review" "$SKILLS_DIR/"

echo "✓ irondev skills → $SKILLS_DIR"
echo "  /irondev-review  — 5-lens code review"
echo "  /irondev         — full orchestrated dev cycle"
