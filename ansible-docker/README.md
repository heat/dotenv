# Ansible Docker Environment

This directory contains a Dockerized environment for running Ansible, including `ansible-builder` and `ansible-navigator`.

## Prerequisites

- Docker
- Docker Compose

## SSH Key Setup

Before starting the container, you need to place your SSH keys in the `.ssh` directory inside this project (`ansible-docker/.ssh`). This allows Ansible inside the container to connect to your remote hosts.

1.  **Create the `.ssh` directory if it doesn't exist:**
    ```bash
    mkdir -p .ssh
    ```

2.  **Copy your SSH keys:**

    Copy your private key (`id_rsa`), public key (`id_rsa.pub`), and any SSH `config` file you might need into the `./.ssh` directory.

    **Important:** This directory is ignored by Git (via `.gitignore`) to prevent your private keys from being accidentally committed.

## How to Use

1.  **Build and Start the Container:**

    Navigate to this directory (`ansible-docker`) in your terminal and run:

    ```bash
    docker-compose up -d
    ```

    This will build the Docker image and start a container named `ansible_control_node` in the background.

2.  **Access the Container:**

    You can get a shell inside the running container using:

    ```bash
    docker exec -it ansible_control_node /bin/bash
    ```

3.  **Run Ansible:**

    The `ansible-dev-env` project from the parent directory is mounted at `/project` inside the container. You can now run your playbooks from there.

    For example:

    ```bash
    # Inside the container
    ansible-playbook -i inventories/dev setup-dev-env.yml
    ```

## Configuration

-   **Dockerfile**: Defines the environment with Python, OpenSSH, and all the required Ansible packages (`ansible`, `ansible-core`, `ansible-builder`, `ansible-navigator`, `ansible-runner`).
-   **docker-compose.yml**:
    -   Builds the `Dockerfile`.
    -   Mounts the `../ansible-dev-env` directory to `/project` in the container.
    -   Mounts your local `~/.ssh` directory to `/root/.ssh` (read-only) to allow Ansible to connect to remote hosts using your existing SSH keys.
