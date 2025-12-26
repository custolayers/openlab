# OpenLab Validation Script: Dependencies Installation Guide

This guide explains how to install all required dependencies to run the OpenLab **design validation scripts** locally.

The validation scripts depend on:

- **git** – for version control (hooks)
- **yq** – for YAML parsing
- **Node.js + ajv-cli** – for JSON Schema validation

---

## 1. Debian / Ubuntu Linux

### 1.1 Update package lists
```bash
sudo apt update
```

### 1.2 Install Git and common utilities
```bash
sudo apt install -y git curl wget
```

### 1.3 Install yq (Mike Farah version)
```bash
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
sudo chmod +x /usr/local/bin/yq
yq --version
```

> ⚠ Make sure this is the **Go/Mike Farah version**, not the Python wrapper.

### 1.4 Install Node.js and npm
```bash
sudo apt install -y nodejs npm
node --version
npm --version
```

### 1.5 Install AJV CLI globally
```bash
npm install -g ajv-cli
ajv --version
```

---

## 2. macOS (Homebrew)

### 2.1 Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2.2 Install Git
```bash
brew install git
git --version
```

### 2.3 Install yq
```bash
brew install yq
yq --version
```

### 2.4 Install Node.js + npm
```bash
brew install node
node --version
npm --version
```

### 2.5 Install AJV CLI globally
```bash
npm install -g ajv-cli
ajv --version
```

---

## 3. Verification

After installation, you should be able to run:

```bash
scripts/validate-designs.sh
```