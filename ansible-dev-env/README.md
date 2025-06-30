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
│   └── development      # Inventário para ambiente local
├── playbooks/           # Playbooks Ansible
│   └── setup-dev-env.yml # Playbook principal
├── roles/               # Roles (componentes reutilizáveis)
│   ├── common/          # Ferramentas comuns de desenvolvimento
│   ├── python/          # Ambiente Python
│   ├── nodejs/          # Ambiente Node.js
│   └── docker/          # Docker e Docker Compose
└── README.md            # Este arquivo
```

## O que será instalado

### Role Common
- Git
- Curl, Wget
- Vim
- Build-essential (compiladores C/C++)
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

### Role Docker
- Docker CE
- Docker CLI
- Docker Compose
- Configuração do usuário no grupo docker

## Como usar

1. Clone este repositório:
```bash
git clone <seu-repositorio>
cd ansible-dev-env
```

2. Execute o playbook:
```bash
# Para executar todo o setup
ansible-playbook -i inventories/development playbooks/setup-dev-env.yml --ask-become-pass

# Para executar apenas roles específicas
ansible-playbook -i inventories/development playbooks/setup-dev-env.yml --tags "python,nodejs" --ask-become-pass
```

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
