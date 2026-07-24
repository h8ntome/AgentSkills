#!/usr/bin/env bash
set -e

# Resolve script folder and repo root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if uv is installed to run with dependencies
if command -v uv &> /dev/null; then
    uv run --with pyyaml python3 "$SCRIPT_DIR/update_skills.py"
else
    # Fallback to standard python3
    if ! python3 -c "import yaml" &> /dev/null; then
        echo "❌ Error: 'yaml' module is required. Please install it via 'pip install pyyaml' or use 'uv'."
        exit 1
    fi
    python3 "$SCRIPT_DIR/update_skills.py"
fi
