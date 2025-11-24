#!/bin/bash

# Trading Intelligence System - Streamlit Application Launcher
# This script activates the virtual environment and starts the Streamlit app

set -e

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change to the project directory
cd "$SCRIPT_DIR"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install/update dependencies
echo "Installing dependencies..."
pip install -q -r requirements.txt

# Create necessary directories
mkdir -p logs data/cache

# Run the Streamlit application
echo "Starting Trading Intelligence System..."
echo "Application will be available at: http://localhost:8501"
echo ""

streamlit run streamlit_app/app.py
