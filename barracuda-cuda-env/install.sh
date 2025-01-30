#!/bin/bash

# Variables
SERVICE_FILE="service/barracuda-cuda-env.service"
SCRIPT_FILE="service/write_cuda_vars.sh"
SERVICE_TARGET_DIR="/etc/systemd/system"

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

# Install the service file
echo "Installing the CUDA environment variables service..."
if [[ -f "$SERVICE_FILE" ]]; then
    cp "$SERVICE_FILE" "$SERVICE_TARGET_DIR"
    echo "Service file installed to $SERVICE_TARGET_DIR"
else
    echo "Error: $SERVICE_FILE not found!" >&2
    exit 1
fi

# Install the script file
echo "Installing the CUDA environment variables script..."
if [[ -f "$SCRIPT_FILE" ]]; then
    cp "$SCRIPT_FILE" "$SERVICE_TARGET_DIR"
    echo "Script file installed to $SERVICE_TARGET_DIR"
else
    echo "Error: $SCRIPT_FILE not found!" >&2
    exit 1
fi

# Reload systemd to recognize the new service
echo "Reloading systemd..."
systemctl daemon-reload

# Enable the service to run on boot
echo "Enabling the service..."
systemctl enable barracuda-cuda-env.service

echo "Installation complete!"
echo "You can start the service with:"
echo "  sudo systemctl start barracuda-cuda-env.service"
