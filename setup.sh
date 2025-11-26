#!/usr/bin/env bash
set -euo pipefail
REQ_FILE="${1:-requirements.txt}"

if [ ! -f "$REQ_FILE" ]; then
  echo "Requirements file not found: $REQ_FILE" >&2
  exit 1
fi

echo "Creating virtual environment in ./.venv..."
python3 -m venv .venv

echo "Activating virtual environment..."
# shellcheck disable=SC1091
source .venv/bin/activate

echo "Upgrading pip and installing requirements..."
python -m pip install --upgrade pip
python -m pip install -r "$REQ_FILE"

echo "Setup complete. Activate with: source .venv/bin/activate"
