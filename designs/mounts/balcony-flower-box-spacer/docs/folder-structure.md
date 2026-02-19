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
