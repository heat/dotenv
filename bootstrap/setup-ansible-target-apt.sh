#!/bin/bash
#
# This script prepares a Debian/Ubuntu based system to be an Ansible managed node.
# It installs OpenSSH server, Python 3, and configures SSH access.
#
# USAGE: Run this script as root, passing the target user's name as an argument.
# Example: ./setup-ansible-target-apt.sh myuser
#

# Exit on any error
set -e

# --- Ensure the script is run as root ---
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

# Update package list
echo "Updating package list..."
apt-get update

# Install sudo
echo "Installing sudo..."
apt-get install -y sudo

# Install OpenSSH Server
echo "Installing OpenSSH Server..."
apt-get install -y openssh-server

# Install Python 3
echo "Installing Python 3..."
apt-get install -y python3

# Get the directory where the script is located
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Copy custom sshd_config if it exists in the script's directory
SSHD_CONFIG_SOURCE="$SCRIPT_DIR/sshd_config"
if [ -f "$SSHD_CONFIG_SOURCE" ]; then
    echo "Backing up existing sshd_config to /etc/ssh/sshd_config.bak..."
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
    
    echo "Copying custom sshd_config..."
    cp "$SSHD_CONFIG_SOURCE" /etc/ssh/sshd_config
    
    echo "Validating new sshd_config..."
    if ! sshd -t; then
        echo "Error: New sshd_config is invalid. Restoring backup."
        mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
        exit 1
    fi
else
    echo "Custom sshd_config not found in script directory. Skipping."
fi

# --- Install Public Key for a specified user ---
PUBLIC_KEY_SOURCE="$SCRIPT_DIR/authorized_key.pub"
if [ -f "$PUBLIC_KEY_SOURCE" ]; then
    # The target username must be passed as the first argument
    if [ -z "$1" ]; then
        echo "Usage: $0 <username>"
        echo "Please provide the username for whom the SSH key should be installed."
        exit 1
    fi
    TARGET_USER="$1"

    # Check if user exists
    if ! id "$TARGET_USER" &>/dev/null; then
        echo "Error: User '$TARGET_USER' not found."
        exit 1
    fi
    
    TARGET_HOME=$(eval echo ~$TARGET_USER)
    
    echo "Setting up SSH key for user '$TARGET_USER'..."
    
    # Create .ssh directory and set permissions.
    # 'sudo -u' is used here because it's the standard way for the root user
    # to execute a command as another user.
    sudo -u "$TARGET_USER" mkdir -p "$TARGET_HOME/.ssh"
    sudo -u "$TARGET_USER" chmod 700 "$TARGET_HOME/.ssh"
    
    # Append the key, ensuring no duplicates, and set permissions
    TARGET_AUTH_KEYS_FILE="$TARGET_HOME/.ssh/authorized_keys"

    # Ensure the authorized_keys file exists and has correct ownership
    sudo -u "$TARGET_USER" touch "$TARGET_AUTH_KEYS_FILE"

    # Check if key already exists to prevent duplicates
    if sudo -u "$TARGET_USER" grep -qF -- "$(cat "$PUBLIC_KEY_SOURCE")" "$TARGET_AUTH_KEYS_FILE" 2>/dev/null; then
        echo "Public key already exists in $TARGET_AUTH_KEYS_FILE. Skipping."
    else
        echo "Appending public key to $TARGET_AUTH_KEYS_FILE..."
        sudo -u "$TARGET_USER" bash -c "cat '$PUBLIC_KEY_SOURCE' >> '$TARGET_AUTH_KEYS_FILE'"
        echo "Public key for '$TARGET_USER' appended successfully."
    fi

    # Always ensure correct permissions on the file
    sudo -u "$TARGET_USER" chmod 600 "$TARGET_AUTH_KEYS_FILE"
else
    echo "Public key file (authorized_key.pub) not found in script directory. Skipping key installation."
fi

# Enable and restart SSH service
echo "Enabling and restarting SSH service..."
systemctl enable ssh
systemctl restart ssh

echo "----------------------------------------"
echo "Setup complete!"
echo "The system is now ready to be managed by Ansible."
if [ -f "$PUBLIC_KEY_SOURCE" ] && [ -n "$1" ]; then
    echo "SSH public key has been installed for user '$1'."
else
    echo "Remember to copy your SSH public key to the target user if you haven't already."
fi
echo "----------------------------------------"
