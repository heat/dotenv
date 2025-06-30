# Golang Role

This role installs Go 1.24 on Ubuntu/Debian systems.

## Requirements

- Ubuntu 20.04+ or Debian 10+
- Ansible 2.9+

## Role Variables

None required. The role installs Go 1.24 by default.

## Dependencies

None.

## Example Playbook

```yaml
- hosts: servers
  roles:
    - golang
```

## What this role does

1. Installs required dependencies (wget, tar)
2. Downloads Go 1.24 from the official website
3. Extracts and installs Go to `/usr/local/go`
4. Sets up environment variables in `/etc/profile.d/golang.sh`
5. Creates Go workspace directory at `~/go`
6. Verifies the installation

## Environment Variables

The role sets up the following environment variables:
- `PATH`: Adds `/usr/local/go/bin` and `$GOPATH/bin`
- `GOPATH`: Set to `$HOME/go`

## License

MIT
