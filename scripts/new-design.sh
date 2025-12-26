#!/usr/bin/env bash
set -euo pipefail

# -------------------------------------------------------------------
# OpenLab – New Design Solution Generator
# -------------------------------------------------------------------

# Determine repo root based on the script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Arguments
if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <category> <design-solution-slug> \"<Title>\""
  exit 1
fi

CATEGORY="$1"
SOLUTION="$2"
TITLE="$3"

# Design solution path relative to repo root
BASE_DIR="$REPO_ROOT/designs/${CATEGORY}/${SOLUTION}"

# Prevent creating in scripts folder
if [[ -d "$BASE_DIR" ]]; then
  echo "❌ Design solution already exists: $BASE_DIR"
  exit 1
fi

echo "🚧 Creating new design solution:"
echo "  Category : $CATEGORY"
echo "  Solution : $SOLUTION"
echo "  Title    : $TITLE"
echo

# -------------------------------------------------------------------
# Create directory structure
# -------------------------------------------------------------------

mkdir -p "$BASE_DIR"/{cad/{parts,assemblies,exports},assets,docs}

# -------------------------------------------------------------------
# Generate design.md (schema-compliant)
# -------------------------------------------------------------------

cat > "$BASE_DIR/design.md" <<EOF
---
design_id: ${CATEGORY}-${SOLUTION}
title: ${TITLE}
summary: >
  Short summary of the design solution.
  Explain the intent, context, and what problem
  this solution is addressing.
status: experimental
category: ${CATEGORY}
context:
  - example-context
tags:
  - example-tag
tested_materials: []
bom: []
---

## Overview

Describe the design solution at a high level.
What is it? Why does it exist?

## Design Intent

Explain the core idea behind this solution.
What constraints or goals influenced the design?

## Notes

- Assembly structure
- Print orientation
- Known limitations
- Open questions
EOF

# -------------------------------------------------------------------
# Optional README.md
# -------------------------------------------------------------------

cat > "$BASE_DIR/README.md" <<EOF
# ${TITLE}

This folder contains a **design solution** developed as part of OpenLab.

Refer to \`design.md\` for structured metadata and lifecycle status.
EOF

# -------------------------------------------------------------------
# Starter docs
# -------------------------------------------------------------------

cat > "$BASE_DIR/docs/notes.md" <<EOF
# Design Notes

Use this file for:
- experiments
- open questions
- future ideas
EOF

# -------------------------------------------------------------------
# Placeholder CAD README
# -------------------------------------------------------------------

cat > "$BASE_DIR/cad/README.md" <<EOF
# CAD Structure

- parts/       Individual CAD parts
- assemblies/  Assemblies referencing parts
- exports/     Neutral formats (STEP, STL)
EOF

echo "✅ Design solution created at:"
echo "   $BASE_DIR"
echo
echo "👉 Next steps:"
echo "   - Edit design.md"
echo "   - Add CAD files under cad/"
echo "   - Add images under assets/"