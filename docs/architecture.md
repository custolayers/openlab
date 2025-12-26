# OpenLab Architecture

## Goals

- Low friction for experimentation
- Strong structure without bureaucracy
- Git-native lifecycle management

## Design Units

The primary unit is a *design solution*.
A solution may contain multiple parts and assemblies.

## Repository Responsibility

This repository is the authoritative source for:
- design data
- metadata schema
- validation rules

The website repository is a read-only consumer.

## Validation Architecture

- JSON Schema defines the contract
- Pre-push hook validates locally
- GitHub Actions enforces on PRs

## Lifecycle States

Designs move through:
- experimental
- validated
- stable
- deprecated

No deadlines, no forced progression.

## Why Not a PLM?

(brief explanation of Git + schema approach)

## Future Extensions

- BOM extraction
- Automated exports
- ERP integration