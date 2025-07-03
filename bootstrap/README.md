# Bootstrap Scripts for Ansible Managed Nodes

This directory contains scripts to prepare a target machine to be managed by Ansible. These scripts install dependencies, configure SSH, and can automatically deploy an SSH public key.

## Scripts

- `setup-ansible-target-apt.sh`: For Debian/Ubuntu based systems.
- `setup-ansible-target-pacman.sh`: For Arch Linux based systems.

## Usage

These scripts are designed to be run from a directory that also contains the necessary configuration files.

1.  **Prepare the Bootstrap Directory:**
    On your control machine, create a temporary directory.
    ```bash
    mkdir bootstrap_payload
    cd bootstrap_payload
    ```

2.  **Copy Files:**
    *   Copy the appropriate setup script (`setup-ansible-target-apt.sh` or `setup-ansible-target-pacman.sh`) into this directory.
    *   (Optional) Copy your custom `sshd_config` file into the directory. The script will use this to configure the SSH server.
    *   (Optional) Copy your SSH public key into the directory and name it `authorized_key.pub`. The script will install this key for the user running the script.

3.  **Transfer to Target:**
    Copy the entire directory to the target machine.
    ```bash
    scp -r ./bootstrap_payload user@target-machine-ip:~/
    ```

4.  **Execute on Target:**
    SSH into the target machine, navigate to the directory, make the script executable, and run it as `root`, passing the username you want to configure as an argument.
    ```bash
    ssh user@target-machine-ip
    cd bootstrap_payload
    chmod +x <script-name>.sh
    sudo ./<script-name>.sh your_username
    ```
    Alternatively, if you are logged in as root:
    ```bash
    ./<script-name>.sh your_username
    ```

The script will:
- Install `openssh-server` and `python3`.
- Copy your `sshd_config` (if provided).
- Install your `authorized_key.pub` for the specified user (if provided).
- Restart the SSH service.

After the script finishes, the machine will be ready to receive connections from your Ansible control node.
