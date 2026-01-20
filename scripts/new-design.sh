#!/usr/bin/env bash

# -------------------------------------------------------------------
# OpenLab – New Design Solution Generator
# -------------------------------------------------------------------

# Arguments check FIRST (before set -euo pipefail)
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <category> <design-solution-slug> \"<Title>\""
  echo ""
  echo "Example: $0 mounts fan-controller \"Fan Controller Mount\""
  echo ""
  echo "Common categories: mounts, tools, organizational, functional, decorative"
  exit 1
fi

# NOW enable strict mode
set -euo pipefail

# Determine repo root based on the script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

CATEGORY="$1"
SOLUTION="$2"
TITLE="$3"

# Design solution path relative to repo root
BASE_DIR="$REPO_ROOT/designs/${CATEGORY}/${SOLUTION}"

# Prevent creating duplicate
if [ -d "$BASE_DIR" ]; then
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

mkdir -p "$BASE_DIR"/{cad/{source,export},images,docs,slicer-profiles}

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

See \`slicer-profiles/\` folder for complete PrusaSlicer project files (.3mf) with all print settings embedded.

**Quick Reference:**
- **Material**: PLA/PETG/ABS
- **Layer Height**: 0.2mm
- **Supports**: Yes/No

## Files & Resources

- **CAD Source**: \`cad/source/\` - Original editable files (.f3d, .step)
- **STL Export**: \`cad/export/\` - Print-ready STL files
- **Slicer Profiles**: \`slicer-profiles/\` - PrusaSlicer .3mf with all settings
- **Images**: \`images/\` - Cover image, renders, and photos
- **Documentation**: \`docs/\` - Detailed guides and notes

See \`docs/folder-structure.md\` for naming conventions and organization details.

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

This design is released under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) - 
Personal and educational use only. Commercial use requires permission.
EOF

# -------------------------------------------------------------------
# Create folder structure documentation
# -------------------------------------------------------------------

cat > "$BASE_DIR/docs/folder-structure.md" <<'EOF'
# Folder Structure & Naming Conventions

This document describes the organization and naming conventions for all files in this design.

## Directory Overview

```
design-name/
├── README.md              # Main documentation (you are here)
├── images/                # Visual assets
├── cad/
│   ├── source/           # Original CAD files
│   └── export/           # Print-ready exports
├── slicer-profiles/      # PrusaSlicer .3mf files
└── docs/                 # Additional documentation
    ├── folder-structure.md
    ├── printing.md
    └── assembly.md
```

---

## images/

**Purpose**: All visual assets including cover image, renders, and photos.

### Required Files
- `cover.jpg` - Main preview image (REQUIRED for portfolio)
  - Square aspect ratio (1:1) recommended
  - Minimum 800x800px, ideally 2048x2048px
  - High quality, well-lit, clean background

### Optional Files
- `render-*.jpg` - CAD renders from different angles
  - Example: `render-isometric.jpg`, `render-front.jpg`
- `photo-*.jpg` - Photos of physical prints
  - Example: `photo-installed.jpg`, `photo-detail.jpg`
- `assembly-*.jpg` - Assembly process photos
  - Example: `assembly-step1.jpg`, `assembly-step2.jpg`

### Naming Convention
```
cover.jpg                 # Main preview (REQUIRED)
render-isometric.jpg      # CAD render views
render-front.jpg
render-side.jpg
photo-printed.jpg         # Physical print photos
photo-installed.jpg
photo-detail-*.jpg        # Close-up details
assembly-step*.jpg        # Assembly instructions
```

---

## cad/source/

**Purpose**: Original, editable CAD files with full parametric history.

### File Formats
- `.f3d` - Fusion 360 native format
- `.FCStd` - FreeCAD native format
- `.step` or `.stp` - Universal CAD exchange format

### Naming Convention

**Single-part designs:**
```
design-name.f3d
design-name.step
```

**Multi-part designs (recommended):**
```
design-name_assembly.f3d          # Main assembly file
design-name_part-body.f3d         # Individual part files
design-name_part-lid.f3d
design-name_part-mount.f3d
```

**Alternative (with subassemblies):**
```
design-name_asm-main.f3d
design-name_asm-housing.f3d
design-name_part-base.f3d
design-name_part-cover.f3d
```

### Best Practices
- Keep parametric history for easy modifications
- Use descriptive part names
- One assembly file for multi-part designs
- Export universal `.step` format for compatibility
- Document design intent in file (parameters, sketches)

---

## cad/export/

**Purpose**: Print-ready STL files, optimized and oriented for 3D printing.

### File Format
- `.stl` - Binary format preferred (smaller file size)
  - Units: millimeters
  - Resolution: Fine/High quality
  - Must be manifold (watertight, no errors)

### Naming Convention

**Single-part designs:**
```
design-name.stl
```

**Multi-part designs:**
```
design-name_body.stl
design-name_lid.stl
design-name_mount-left.stl
design-name_mount-right.stl
```

**With print quantities (optional):**
```
design-name_body.stl              # Print 1x
design-name_drawer.stl            # Print 3x (note in README)
design-name_spacer.stl            # Print 4x (note in README)
```

**Versioned exports (optional):**
```
design-name_v1.0.stl
design-name_v2.0.stl
```

### Best Practices
- One STL per printable part
- Orient for optimal printing before export
- Check mesh quality (no errors, manifold)
- Include print quantities in main README if needed
- Use descriptive suffixes for left/right, top/bottom variants

---

## slicer-profiles/

**Purpose**: PrusaSlicer/SuperSlicer project files with embedded settings.

### File Format
- `.3mf` - PrusaSlicer project file
  - Includes model, orientation, supports, and ALL print settings
  - Contains print/filament/printer profiles

### Naming Convention

**Single configuration:**
```
design-name.3mf
```

**Multiple configurations:**
```
design-name_standard.3mf          # Default settings
design-name_fast.3mf              # Speed-optimized
design-name_quality.3mf           # Quality-optimized
design-name_PETG.3mf              # Material-specific
```

### What's Included in .3mf
- Complete 3D model
- Part orientation
- Support structures and placement
- Print settings (speeds, temperatures, cooling)
- Filament settings (material type, temperatures)
- Printer settings (bed size, nozzle diameter)

### Best Practices
- Save entire project, not just exported G-code
- Include tested, working settings
- Document printer model and material used
- Update when design or settings change

---

## docs/

**Purpose**: Additional documentation beyond the main README.

### Standard Files
- `folder-structure.md` - This file (organization guide)
- `printing.md` - Detailed printing guide
- `assembly.md` - Step-by-step assembly instructions

### Optional Files
- `notes.md` - Design notes, ideas, improvements
- `testing.md` - Test results, iterations
- `bom.md` - Detailed bill of materials
- `changelog.md` - Version history

### Best Practices
- Keep docs focused and scannable
- Use markdown formatting
- Include images where helpful
- Link to external resources when appropriate

---

## Complete Example Structure

### Example 1: Simple Single-Part Design
```
phone-stand/
├── README.md
├── images/
│   ├── cover.jpg
│   ├── render-isometric.jpg
│   └── photo-printed.jpg
├── cad/
│   ├── source/
│   │   ├── phone-stand.f3d
│   │   └── phone-stand.step
│   └── export/
│       └── phone-stand.stl
├── slicer-profiles/
│   └── phone-stand.3mf
└── docs/
    ├── folder-structure.md
    └── printing.md
```

### Example 2: Multi-Part Assembly
```
desk-organizer/
├── README.md
├── images/
│   ├── cover.jpg
│   ├── render-isometric.jpg
│   ├── render-exploded.jpg
│   ├── photo-assembled.jpg
│   └── assembly-step1.jpg
├── cad/
│   ├── source/
│   │   ├── organizer_assembly.f3d
│   │   ├── organizer_part-base.f3d
│   │   ├── organizer_part-drawer.f3d
│   │   └── organizer.step
│   └── export/
│       ├── organizer_base.stl
│       ├── organizer_drawer.stl        # Print 3x
│       └── organizer_divider.stl       # Print 2x
├── slicer-profiles/
│   ├── organizer_base.3mf
│   └── organizer_drawer.3mf
└── docs/
    ├── folder-structure.md
    ├── printing.md
    └── assembly.md
```

### Example 3: Design with Variants
```
mounting-bracket/
├── README.md
├── images/
│   ├── cover.jpg
│   └── render-all-sizes.jpg
├── cad/
│   ├── source/
│   │   ├── bracket_parametric.f3d
│   │   └── bracket.step
│   └── export/
│       ├── bracket_40mm.stl
│       ├── bracket_50mm.stl
│       └── bracket_60mm.stl
├── slicer-profiles/
│   └── bracket_50mm.3mf            # Most common size
└── docs/
    ├── folder-structure.md
    └── printing.md
```

---

## Quick Reference

| Folder | Purpose | Key Files |
|--------|---------|-----------|
| `images/` | Visuals | `cover.jpg` (required), renders, photos |
| `cad/source/` | Editable CAD | `.f3d`, `.step` files |
| `cad/export/` | Print-ready | `.stl` files |
| `slicer-profiles/` | Settings | `.3mf` PrusaSlicer projects |
| `docs/` | Documentation | `.md` markdown files |

---

## Tips

1. **Always include cover.jpg** - Required for Hugo portfolio
2. **Name files descriptively** - Future you will thank you
3. **Keep source and export separate** - Don't mix editable and export files
4. **Use .3mf for settings** - Much easier than documenting manually
5. **Document print quantities** - Note in README if parts need multiple prints
6. **Version important changes** - Consider versioning when making significant updates
EOF

# -------------------------------------------------------------------
# Optional docs folder starter (simplified)
# -------------------------------------------------------------------

cat > "$BASE_DIR/docs/printing.md" <<'EOF'
# Printing Guide

## Slicer Profiles

Complete PrusaSlicer .3mf files with all settings are available in `slicer-profiles/` folder.

Simply open the .3mf file in PrusaSlicer and slice - all settings are pre-configured.

## Print Orientation

Describe optimal print orientation and why.

## Common Issues

- Issue 1 and solution
- Issue 2 and solution

## Post-Processing

- Cleanup steps
- Assembly preparation
EOF

cat > "$BASE_DIR/docs/assembly.md" <<'EOF'
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
touch "$BASE_DIR/slicer-profiles/.gitkeep"

echo "✅ Design solution created at:"
echo "   $BASE_DIR"
echo
echo "📁 Directory structure:"
echo "   ├── README.md (main documentation)"
echo "   ├── images/ (add cover.jpg + other images)"
echo "   ├── cad/"
echo "   │   ├── source/ (original CAD files: .f3d, .step)"
echo "   │   └── export/ (print-ready: .stl)"
echo "   ├── slicer-profiles/ (PrusaSlicer .3mf with settings)"
echo "   └── docs/ (detailed guides + folder-structure.md)"
echo
echo "👉 Next steps:"
echo "   1. Edit README.md with design details"
echo "   2. Add cover.jpg to images/ folder (REQUIRED for portfolio)"
echo "   3. Add CAD source files to cad/source/ (.f3d, .step)"
echo "   4. Export STL files to cad/export/ (.stl)"
echo "   5. Save PrusaSlicer project to slicer-profiles/ (.3mf)"
echo "   6. Add photos/renders to images/"
echo "   7. Review docs/folder-structure.md for naming conventions"
echo
echo "🖼️  Image naming conventions:"
echo "   - cover.jpg (REQUIRED - square aspect, min 800x800px)"
echo "   - render-*.jpg (CAD renders)"
echo "   - photo-*.jpg (physical prints)"
echo "   - assembly-*.jpg (assembly steps)"
echo
echo "📝 To add to Hugo portfolio:"
echo "   hugo new content/designs/openlab/${CATEGORY}/${SOLUTION}/index.md"