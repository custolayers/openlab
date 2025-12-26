#!/usr/bin/env bash
set -euo pipefail

SCHEMA="schema/design.schema.json"
FAILED=0

echo "🔍 Validating design metadata…"

if ! command -v yq >/dev/null; then
  echo "❌ yq not found"
  exit 2
fi

if ! command -v ajv >/dev/null; then
  echo "❌ ajv not found"
  exit 2
fi

for file in $(find designs -name design.md 2>/dev/null); do
  echo "→ $file"

  # extract YAML front-matter
  yq eval 'select(fileIndex == 0)' "$file" >/tmp/design.yaml
  yq -o=json '.' /tmp/design.yaml >/tmp/design.json

  if ! ajv validate -s "$SCHEMA" -d /tmp/design.json; then
    echo "❌ Validation failed: $file"
    FAILED=1
  else
    echo "✅ OK"
  fi
done

rm -f /tmp/design.yaml /tmp/design.json

exit $FAILED
