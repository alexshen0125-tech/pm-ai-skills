#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-both}"
EDITION="${2:-full}"
REPO="${PM_AI_SKILLS_REPO:-https://github.com/alexshen0125-tech/pm-ai-skills.git}"

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

validate_manifest() {
  local manifest="$1"

  while IFS= read -r skill || [[ -n "$skill" ]]; do
    skill="${skill%$'\r'}"
    [[ -z "$skill" ]] && continue
    if [[ ! "$skill" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
      echo "invalid skill name in $manifest: $skill" >&2
      return 1
    fi
    if [[ ! -f "$TMP_DIR/repo/skills/$skill/SKILL.md" ]]; then
      echo "missing SKILL.md for $skill in $manifest" >&2
      return 1
    fi
  done < "$manifest"
}

install_manifest() {
  local manifest="$1"
  local destination="$2"

  mkdir -p "$destination"
  while IFS= read -r skill || [[ -n "$skill" ]]; do
    skill="${skill%$'\r'}"
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
  validate_manifest "$TMP_DIR/repo/manifests/codex-$EDITION.txt"
fi

if [[ "$TARGET" == "claude" || "$TARGET" == "both" ]]; then
  validate_manifest "$TMP_DIR/repo/manifests/claude-$EDITION.txt"
fi

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
