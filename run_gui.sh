#!/bin/bash

# Script to run the Avatar GUI application with proper environment setup
# Usage: ./run_gui.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to the project directory
cd "$SCRIPT_DIR" || exit 1

# Check if virtual environment exists
VENV_DIR=""
if [ -d "venv" ]; then
    VENV_DIR="venv"
elif [ -d ".venv" ]; then
    VENV_DIR=".venv"
else
    echo "Error: Virtual environment not found!"
    echo "Please create a virtual environment first:"
    echo "  python3 -m venv venv"
    echo "  OR"
    echo "  python3 -m venv .venv"
    echo "Then activate and install dependencies:"
    echo "  source venv/bin/activate  # or source .venv/bin/activate"
    echo "  pip install -r requirements.txt"
    exit 1
fi

# Activate virtual environment
echo "Activating virtual environment ($VENV_DIR)..."
source "$VENV_DIR/bin/activate"

# Verify Python version in venv
echo "Using Python: $(python --version)"

# Check if required packages are installed
echo "Checking dependencies..."
python -c "import PySide6" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Error: PySide6 not found. Installing dependencies..."
    pip install -r requirements.txt
fi

# Check for additional required packages
echo "Verifying additional dependencies..."
python -c "import pandas; import matplotlib; import sklearn" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Installing additional required packages..."
    pip install pandas matplotlib scikit-learn
fi

echo "Starting Avatar GUI..."
echo "========================================"
python app.py

# Deactivate virtual environment on exit
deactivate

