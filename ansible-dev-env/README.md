# Ansible Development Environment Setup

Este projeto Ansible automatiza a configuração de um ambiente de desenvolvimento completo.

## Pré-requisitos

- Sistema operacional: Ubuntu/Debian (testado no Ubuntu 20.04+)
- Ansible instalado na máquina local

### Instalando o Ansible

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install ansible -y

# Ou via pip
pip3 install ansible
```

## Estrutura do Projeto

```
ansible-dev-env/
├── inventories/          # Arquivos de inventário
│   ├── development      # Inventário para ambiente local
│   └── wsl             # Inventário para Windows Subsystem for Linux
├── playbooks/           # Playbooks Ansible
│   └── setup-dev-env.yml # Playbook principal
├── roles/               # Roles (componentes reutilizáveis)
│   ├── common/          # Ferramentas comuns de desenvolvimento
│   ├── python/          # Ambiente Python
│   ├── nodejs/          # Ambiente Node.js
│   ├── golang/          # Ambiente Go
│   ├── docker/          # Docker e Docker Compose
│   └── zsh/             # Zsh e Oh My Zsh
└── README.md            # Este arquivo
```

## O que será instalado

### Role Common
- Git, Curl, Wget, Vim
- Tmux (multiplexador de terminal)
- Tree (visualizador de estrutura de diretórios)
- Stow (gerenciador de links simbólicos)
- Build-essential, Make, Autoconf, Automake
- Terraform (infraestrutura como código)
- Lazygit (interface TUI para Git)
- Ferramentas de rede: net-tools, ping, traceroute, dig, netcat, nmap, tcpdump, iftop
- Htop (monitor de processos)
- Ferramentas de sistema essenciais

### Role Python
- Python 3
- pip
- venv
- Ferramentas de desenvolvimento: pipenv, virtualenv, black, flake8, pytest, ipython

### Role Node.js
- NVM (Node Version Manager)
- Node.js 22.x (instalado via NVM)
- npm (incluído com Node.js)

### Role Golang
- Go 1.24
- Configuração de GOPATH
- Variáveis de ambiente configuradas em /etc/profile.d/golang.sh

### Role Docker
- Docker CE
- Docker CLI
- Docker Compose
- Configuração do usuário no grupo docker

### Role Zsh
- Zsh como shell padrão
- Configurações básicas: histórico, autocompletar, cores
- Prompt colorido e funcional
- Aliases customizados para produtividade
- Integração com variáveis de ambiente em /etc/profile.d/

## Como usar

1. Clone este repositório:
```bash
git clone <seu-repositorio>
cd ansible-dev-env
```

2. Execute o playbook:
```bash
# Para executar todo o setup no ambiente local
ansible-playbook -i inventories/development playbooks/setup-dev-env.yml --ask-become-pass

# Para executar no WSL (Windows Subsystem for Linux)
ansible-playbook -i inventories/wsl playbooks/setup-dev-env.yml --ask-become-pass

# Para executar apenas roles específicas
ansible-playbook -i inventories/development playbooks/setup-dev-env.yml --tags "python,nodejs" --ask-become-pass
```

### Usando com WSL

Para usar com o WSL, você precisa:
1. Configurar SSH no WSL (veja `inventories/README.md` para instruções detalhadas)
2. Editar o arquivo `inventories/wsl` com suas informações de conexão
3. Executar o playbook usando o inventário WSL

## Personalizando

### Adicionando novos pacotes

Para adicionar novos pacotes a uma role, edite o arquivo `tasks/main.yml` da role correspondente.

### Criando novas roles

1. Crie um novo diretório em `roles/`:
```bash
mkdir -p roles/nova-role/tasks
```

2. Crie o arquivo `roles/nova-role/tasks/main.yml` com suas tarefas

3. Adicione a role ao playbook `playbooks/setup-dev-env.yml`

### Variáveis

Você pode criar arquivos de variáveis em `group_vars/` ou `host_vars/` para personalizar a instalação.

## Dicas

- Use `--check` para executar em modo dry-run
- Use `-v` ou `-vv` para mais detalhes durante a execução
- Para pular uma role específica, use `--skip-tags "docker"`

## Contribuindo

Sinta-se à vontade para adicionar novas roles ou melhorar as existentes!
