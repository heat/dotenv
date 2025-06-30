# Common Role

Esta role instala ferramentas e pacotes comuns para desenvolvimento.

## Pacotes Instalados

### Ferramentas Básicas
- git - Sistema de controle de versão
- curl - Ferramenta para transferência de dados
- wget - Utilitário para download de arquivos
- vim - Editor de texto
- tmux - Multiplexador de terminal
- tree - Visualizador de estrutura de diretórios
- stow - Gerenciador de links simbólicos
- htop - Monitor de processos interativo

### Ferramentas de Build
- build-essential - Compiladores e ferramentas de build essenciais
- linux-headers-generic - Headers do kernel Linux
- make - Ferramenta de automação de build
- autoconf - Gerador de scripts de configuração
- automake - Gerador de Makefiles

### Ferramentas de Sistema
- software-properties-common - Gerenciamento de repositórios
- apt-transport-https - Suporte HTTPS para APT
- ca-certificates - Certificados CA
- gnupg - GNU Privacy Guard
- lsb-release - Informações da distribuição Linux

### Ferramentas de Rede
- net-tools - Ferramentas de rede clássicas (ifconfig, netstat, etc.)
- iputils-ping - Comando ping
- traceroute - Rastreamento de rotas de rede
- dnsutils - Utilitários DNS (dig, nslookup, etc.)
- netcat - Utilitário de rede versátil
- nmap - Scanner de portas e descoberta de rede
- tcpdump - Captura e análise de pacotes
- iftop - Monitor de tráfego de rede em tempo real

### Ferramentas de Infraestrutura
- terraform - Ferramenta de infraestrutura como código (instalado via repositório HashiCorp)
- lazygit - Interface TUI para Git (instalado via GitHub releases)

## Diretórios Criados

- `~/workspace` - Diretório para projetos
- `~/tools` - Diretório para ferramentas adicionais
- `~/.config` - Diretório de configurações

## Requisitos

- Sistema operacional: Ubuntu/Debian
- Ansible 2.9+

## Uso

Esta role é incluída automaticamente ao executar o playbook principal:

```bash
ansible-playbook -i inventory/dev playbooks/setup-dev-env.yml
```

## Notas

- O Terraform é instalado através do repositório oficial da HashiCorp
- O Lazygit é baixado diretamente das releases do GitHub e instalado em `/usr/local/bin`
- As ferramentas de rede requerem privilégios de root para algumas operações
