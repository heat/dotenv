# Use a stable base image
FROM ubuntu:22.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    openssh-client \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

# Install Ansible tools
RUN python3 -m pip install --no-cache-dir \
    ansible \
    ansible-core \
    ansible-builder \
    ansible-navigator \
    ansible-runner

# Set up a working directory
WORKDIR /project

# Keep the container running
CMD ["tail", "-f", "/dev/null"]
