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
  echo ""
  echo "Example: $0 mounts fan-controller \"Fan Controller Mount\""
  echo ""
  echo "Common categories: mounts, tools, organizational, functional, decorative"
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

mkdir -p "$BASE_DIR"/{cad/{source,export},images,docs}

# -------------------------------------------------------------------
# Generate README.md (main documentation)
# -------------------------------------------------------------------

cat > "$BASE_DIR/README.md" <<EOF
# ${TITLE}

<!-- Add a brief one-line description here -->
A [brief description of what this design does/solves].

## Overview

Describe the design solution at a high level. What is it? Why does it exist?
What problem does it solve?

## Features

- Feature 1
- Feature 2
- Feature 3

## Design Intent

Explain the core idea behind this solution.
What constraints or goals influenced the design?

## Print Settings

- **Material**: PLA/PETG/ABS
- **Layer Height**: 0.2mm
- **Infill**: 15-20%
- **Supports**: Yes/No
- **Print Time**: ~X hours
- **Material Used**: ~Xg

## Assembly

1. Step 1
2. Step 2
3. Step 3

## Bill of Materials

| Item | Quantity | Notes |
|------|----------|-------|
| Printed parts | 1 | Main body |
| M3 screws | 4 | Optional description |

## Notes & Tips

- Print orientation recommendations
- Assembly tips
- Known limitations
- Maintenance recommendations

## Version History

- **v1.0** ($(date +%Y-%m-%d)) - Initial release

## License

This design is released under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) 
or your preferred license.
EOF

# -------------------------------------------------------------------
# Optional docs folder starter
# -------------------------------------------------------------------

cat > "$BASE_DIR/docs/printing.md" <<EOF
# Printing Guide

## Recommended Settings

- **Printer**: [Your printer model]
- **Material**: PLA/PETG/ABS
- **Nozzle**: 0.4mm
- **Layer Height**: 0.2mm
- **Infill**: 15-20%
- **Supports**: Yes/No
- **Adhesion**: Brim/Raft/None

## Print Orientation

Describe optimal print orientation and why.

## Common Issues

- Issue 1 and solution
- Issue 2 and solution

## Post-Processing

- Cleanup steps
- Assembly preparation
EOF

cat > "$BASE_DIR/docs/assembly.md" <<EOF
# Assembly Instructions

## Tools Required

- Tool 1
- Tool 2

## Parts Checklist

- [ ] Printed part 1
- [ ] Printed part 2
- [ ] Hardware (screws, etc.)

## Step-by-Step

### Step 1: [Description]

Detailed instructions...

### Step 2: [Description]

Detailed instructions...

## Testing

How to verify the assembly is correct.
EOF

# -------------------------------------------------------------------
# Create .gitkeep for empty folders
# -------------------------------------------------------------------

touch "$BASE_DIR/cad/source/.gitkeep"
touch "$BASE_DIR/cad/export/.gitkeep"
touch "$BASE_DIR/images/.gitkeep"

echo "✅ Design solution created at:"
echo "   $BASE_DIR"
echo
echo "📁 Directory structure:"
echo "   ├── README.md (main documentation)"
echo "   ├── images/ (add cover.jpg + other images)"
echo "   ├── cad/"
echo "   │   ├── source/ (original CAD files: .f3d, .step)"
echo "   │   └── export/ (print-ready: .stl, .3mf)"
echo "   └── docs/ (optional detailed guides)"
echo
echo "👉 Next steps:"
echo "   1. Edit README.md with design details"
echo "   2. Add cover.jpg to images/ folder (REQUIRED for portfolio)"
echo "   3. Add CAD source files to cad/source/ (.f3d, .step)"
echo "   4. Export print-ready files to cad/export/ (.stl, .3mf)"
echo "   5. Add photos/renders to images/"
echo
echo "🖼️  Image naming conventions:"
echo "   - cover.jpg (REQUIRED - square aspect, min 800x800px)"
echo "   - render-*.jpg (CAD renders)"
echo "   - photo-*.jpg (physical prints)"
echo "   - assembly-*.jpg (assembly steps)"
echo
echo "📝 To add to Hugo portfolio:"
echo "   hugo new content/designs/openlab/${CATEGORY}/${SOLUTION}/index.md"