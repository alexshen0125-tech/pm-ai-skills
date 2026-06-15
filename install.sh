#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-both}"
EDITION="${2:-full}"
REPO="https://github.com/alexshen0125-tech/pm-ai-skills.git"

if [[ "$TARGET" != "codex" && "$TARGET" != "claude" && "$TARGET" != "both" ]]; then
  echo "Usage: install.sh [codex|claude|both] [full|minimal]"
  exit 1
fi

if [[ "$EDITION" != "full" && "$EDITION" != "minimal" ]]; then
  echo "Usage: install.sh [codex|claude|both] [full|minimal]"
  exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth 1 "$REPO" "$TMP_DIR/repo" >/dev/null 2>&1

install_manifest() {
  local manifest="$1"
  local destination="$2"

  mkdir -p "$destination"
  while IFS= read -r skill; do
    [[ -z "$skill" ]] && continue
    if [[ -e "$destination/$skill" ]]; then
      echo "skip: $skill already exists"
      continue
    fi
    cp -R "$TMP_DIR/repo/skills/$skill" "$destination/$skill"
    echo "installed: $skill"
  done < "$manifest"
}

if [[ "$TARGET" == "codex" || "$TARGET" == "both" ]]; then
  install_manifest \
    "$TMP_DIR/repo/manifests/codex-$EDITION.txt" \
    "$HOME/.codex/skills"
fi

if [[ "$TARGET" == "claude" || "$TARGET" == "both" ]]; then
  install_manifest \
    "$TMP_DIR/repo/manifests/claude-$EDITION.txt" \
    "$HOME/.claude/skills"
fi

echo "Done. Restart Codex or Claude Code to load newly installed Skills."
