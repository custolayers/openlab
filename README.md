# Open Lab

Open Lab is a public collection of open design and engineering experiments.
Designs are organized as reusable engineering solutions, not individual parts.

This repository is intentionally **not**:
- a product catalog
- a store
- a polished showcase

Instead, it is a working lab.

## Repository Structure

designs/
  <category>/
    <design-solution>/
      design.md
      cad/
      assets/
      docs/

## Repository structure

All designs live under the `designs/` directory:

```
designs/<category>/<design-solution>/
├── design.md      # authoritative design description
├── cad/           # STEP, STL, native CAD, etc.
├── assets/        # screenshots or photos
└── docs/          # additional documentation (optional)
```

## Design Metadata

Every design **must** include a `design.md` file.

This file:
- describes intent and constraints
- is readable on GitHub
- is consumed by the Custolayers website

Do not duplicate design descriptions elsewhere.

## Validation

Before pushing to `main`, all design metadata is validated
against a JSON schema.

Run locally:

```bash
scripts/validate-designs.sh
```

## Contributing

- Follow the design solution structure
- Do not modify schema files without discussion
- Experimental designs are welcome

## Feedback

Feedback happens via GitHub Issues.
Always reference the **Design ID** when opening an issue.
