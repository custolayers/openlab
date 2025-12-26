#!/usr/bin/env bash
set -euo pipefail

# ----------------------------
# Paths
# ----------------------------
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCHEMA="$REPO_ROOT/schema/design.schema.json"
DESIGNS_DIR="$REPO_ROOT/designs"

# ----------------------------
# Prerequisites
# ----------------------------
command -v yq >/dev/null || { echo "❌ yq not found. Install yq v4+"; exit 1; }
command -v jq >/dev/null || { echo "❌ jq not found. Install jq"; exit 1; }
command -v ajv >/dev/null || { echo "❌ ajv-cli not found. Install ajv-cli"; exit 1; }

# ----------------------------
# Validation start
# ----------------------------
echo "🔍 Validating design solutions in $DESIGNS_DIR"
echo "================================"
echo

FAILED=0
COUNT=0

if [ ! -d "$DESIGNS_DIR" ]; then
  echo "❌ Designs folder not found at $DESIGNS_DIR"
  exit 1
fi

while IFS= read -r -d '' FILE; do
  COUNT=$((COUNT + 1))

  # --- Extract front matter only (between first two --- lines) ---
  FRONTMATTER=$(sed -n '/^---$/,/^---$/p' "$FILE" | sed '1d;$d')

  # Convert YAML to JSON safely
  JSON=$(echo "$FRONTMATTER" | yq eval -o=json)

  # --- Extract design_id and title for printing ---
  DESIGN_ID=$(echo "$JSON" | jq -r '.design_id // "unknown"')
  TITLE=$(echo "$JSON" | jq -r '.title // "unknown"')

  echo "▶ Design: ${DESIGN_ID} — ${TITLE}"
  echo "  File: $FILE"

  # --- YAML syntax check ---
  if ! echo "$FRONTMATTER" | yq eval '.' >/dev/null 2>&1; then
    echo "  ❌ YAML syntax error in front matter"
    FAILED=1
    break
  fi

  # --- Schema validation ---
  if ! echo "$JSON" | ajv validate --strict=false -s "$SCHEMA" -d /dev/stdin >/dev/null; then
    echo "  ❌ Schema validation failed"
    FAILED=1
    break
  fi

  echo "  ✅ Valid"
  echo
done < <(find "$DESIGNS_DIR" -name design.md -print0)

echo "================================"

if [ "$FAILED" -ne 0 ]; then
  echo "❌ Validation failed after $COUNT design(s)"
  exit 1
fi

echo "🎉 All $COUNT design solution(s) validated successfully"