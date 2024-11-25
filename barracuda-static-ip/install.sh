#!/bin/bash

# Variables
SERVICE_FILE="service/barracuda-static-ip.service"
CONF_FILE="config/barracuda-static-ip.conf"
SERVICE_TARGET_DIR="/etc/systemd/system"
CONF_TARGET_DIR="/etc"

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

# Install the service file
echo "Installing the static IP service..."
if [[ -f "$SERVICE_FILE" ]]; then
    cp "$SERVICE_FILE" "$SERVICE_TARGET_DIR"
    echo "Service file installed to $SERVICE_TARGET_DIR"
else
    echo "Error: $SERVICE_FILE not found!" >&2
    exit 1
fi

# Install the configuration file
echo "Installing the static IP configuration file..."
if [[ -f "$CONF_FILE" ]]; then
    cp "$CONF_FILE" "$CONF_TARGET_DIR"
    echo "Configuration file installed to $CONF_TARGET_DIR"
else
    echo "Error: $CONF_FILE not found!" >&2
    exit 1
fi

# Reload systemd to recognize the new service
echo "Reloading systemd..."
systemctl daemon-reload

# Enable the service to run on boot
echo "Enabling the service..."
systemctl enable barracuda-static-ip.service

echo "Installation complete!"
echo "You can start the service with:"
echo "  sudo systemctl start barracuda-static-ip.service"

