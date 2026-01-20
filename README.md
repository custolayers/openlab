# OpenLab

OpenLab is my personal collection of open-source 3D printing designs and engineering experiments.

This repository serves as a structured archive of designs I create and share publicly.

This repository is intentionally **not**:
- a product catalog
- a store
- a polished showcase
- seeking contributions

Instead, it is my working lab for experimental designs, documentation, and iteration.

## Repository Structure

```
designs/
└── <category>/
    └── <design-solution>/
        ├── README.md
        ├── cad/
        │   ├── source/
        │   └── export/
        ├── images/
        ├── slicer-profiles/
        └── docs/
```

All designs live under the `designs/` directory, organized by category:

- `mounts/` - Mounting solutions and brackets
- `tools/` - Workshop tools and utilities
- `organizational/` - Storage and organization systems
- `functional/` - Functional mechanical parts
- And more...

## Design Structure

Each design solution follows this standard structure:

```
designs/<category>/<design-solution>/
├── README.md              # Main design documentation (required)
├── images/                # Visual assets (required)
│   ├── cover.jpg         # Main preview image (required)
│   ├── render-*.jpg      # CAD renders
│   └── photo-*.jpg       # Physical prints
├── cad/
│   ├── source/           # Original CAD files (.f3d, .step)
│   └── export/           # Print-ready files (.stl)
├── slicer-profiles/      # PrusaSlicer .3mf with settings
└── docs/                 # Additional documentation
    ├── folder-structure.md
    ├── printing.md
    └── assembly.md
```

### Required Files

1. **README.md** - Main design documentation
   - Description and overview
   - Features and design intent
   - Print settings reference
   - Assembly instructions
   - Bill of materials
   - Version history

2. **images/cover.jpg** - Main preview image
   - Square aspect ratio (1:1) recommended
   - Minimum 800x800px, ideally 2048x2048px
   - Used for portfolio grid on Custolayers website

### Optional but Recommended

- **cad/source/** - Original editable CAD files for modification
- **cad/export/** - Print-ready STL files
- **slicer-profiles/** - PrusaSlicer .3mf files with embedded settings
- **docs/** - Detailed guides (printing, assembly, folder structure)

## Creating a New Design

Use the provided script to create a properly structured design:

```bash
./scripts/new-design.sh <category> <design-slug> "Design Title"

# Example:
./scripts/new-design.sh mounts wall-bracket "Wall Mounting Bracket"
```

This creates the complete folder structure with template files.

See the generated `docs/folder-structure.md` for naming conventions and best practices.

## Design Documentation

### README.md

Each design's `README.md` is:
- The authoritative design description
- Readable directly on GitHub
- Automatically embedded on the Custolayers website
- Written in Markdown

Do not duplicate design descriptions elsewhere.

### Documentation Guidelines

- Keep README.md focused on the design itself
- Use `docs/` folder for detailed guides (printing, assembly, etc.)
- Include high-quality images in `images/`
- Save complete slicer settings as .3mf files
- Use clear, descriptive file names

## Naming Conventions

### Files and Folders
- Use lowercase with hyphens: `wall-bracket`, `cable-clip`
- Be descriptive: `fan-controller` not `fc1`

### Images
- `cover.jpg` - Main preview (required)
- `render-*.jpg` - CAD renders
- `photo-*.jpg` - Physical prints
- `assembly-*.jpg` - Assembly steps

### CAD Files
- Source: `design-name.f3d`, `design-name.step`
- Export: `design-name.stl`, `design-name_part.stl`
- Multi-part: `design-name_body.stl`, `design-name_lid.stl`

See `docs/folder-structure.md` in any design for complete conventions.

## Using These Designs

All designs are freely available for personal, non-commercial use under the CC BY-NC-SA 4.0 license (unless otherwise noted).

You can:
- ✅ Download and print any design for personal use
- ✅ Modify and adapt for your own needs
- ✅ Share and redistribute (with attribution)
- ❌ Use commercially or for profit

**Non-Commercial Use Only**: These designs are shared for personal, educational, and non-commercial purposes. Commercial use requires explicit permission.

### Downloading Files

1. Browse designs at [custolayers.com](https://custolayers.com) or directly in this repo
2. Navigate to `designs/<category>/<design-name>/`
3. Download STL files from `cad/export/`
4. Optionally download .3mf slicer profiles from `slicer-profiles/`

### Print Settings

Most designs include PrusaSlicer .3mf files with my tested settings embedded.
Simply open the .3mf file in PrusaSlicer and slice.

Alternatively, check the design's README.md for print setting recommendations.

## License

Unless otherwise specified, all designs in this repository are released under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/).

**This means:**
- ✅ **Attribution** - You must give appropriate credit
- ✅ **ShareAlike** - Adaptations must use the same license
- ❌ **NonCommercial** - No commercial use without permission

Individual designs may specify different licenses in their README.md.

**Commercial Use**: If you're interested in commercial use of any design, please contact me to discuss licensing options.

## Feedback & Questions

If you find issues with a design or have questions:
- Open a GitHub Issue with the design name
- Tag issues with the design category (e.g., `mounts`, `tools`)

While I'm not actively seeking contributions, constructive feedback is always welcome.

## About

This repository is:
- My personal design archive
- A learning and experimentation space
- Shared openly for others to use and learn from

All designs are works in progress and may have limitations or improvements planned.

## Integration with Custolayers Website

This repository is used as a git submodule in my [portfolio site](https://custolayers.com).

The website:
- Displays designs in a searchable grid
- Embeds each README.md as the design page
- Links to downloadable CAD files
- Shows cover images and renders

The site updates when I push new designs or updates to this repository.

## Resources

- **Portfolio**: [custolayers.com](https://custolayers.com) - Browse all designs
- **Site Repository**: [github.com/custolayers/site](https://github.com/custolayers/site) - Hugo website source

---

**OpenLab** - Personal archive of open-source 3D printing designs