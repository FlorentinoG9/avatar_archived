#!/bin/bash
# NAO Service Startup Script
# This script starts the NAO connection service for controlling the physical robot

echo "========================================"
echo "Starting NAO Connection Service"
echo "========================================"
echo ""
echo "This service allows the GUI to communicate with the NAO robot"
echo "Make sure the NAO robot is:"
echo "  1. Powered on"
echo "  2. Connected to the same network"
echo "  3. Accessible at IP: 192.168.23.53:9559"
echo ""
echo "Starting service..."
echo ""

# Check if Python 2.7 is available
if command -v python2.7 &> /dev/null; then
    python2.7 "$(dirname "$0")/nao_service.py"
elif command -v python2 &> /dev/null; then
    python2 "$(dirname "$0")/nao_service.py"
else
    echo "ERROR: Python 2.7 is required but not found!"
    echo "Please install Python 2.7 and the NAOqi SDK"
    exit 1
fi

