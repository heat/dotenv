# Ansible Role: Zsh

Esta role configura o Zsh como shell padrão com configurações básicas e úteis.

## Funcionalidades

- Instala o Zsh
- Configura o Zsh como shell padrão do usuário
- Configurações básicas:
  - Histórico de comandos (10000 linhas)
  - Autocompletar melhorado
  - Cores no terminal
  - Prompt básico colorido
  - Key bindings estilo Emacs
- Adiciona aliases úteis para produtividade
- Configura o sourcing automático de arquivos em `/etc/profile.d/`

## Exemplo de uso

```yaml
- hosts: all
  roles:
    - role: zsh
```

## Aliases incluídos

- `ll`: Lista detalhada de arquivos
- `la`: Lista todos os arquivos (incluindo ocultos)
- `l`: Lista compacta
- `..`, `...`, `....`: Navegação rápida de diretórios
- `gs`: git status
- `ga`: git add
- `gc`: git commit
- `gp`: git push
- `gl`: git log com visualização gráfica
- `docker-clean`: Limpa containers, imagens e volumes não utilizados
- `docker-stop-all`: Para todos os containers em execução

## Requisitos

- Ubuntu/Debian
- Ansible 2.9+

## Notas

- A mudança de shell requer logout/login para ter efeito completo
- Os arquivos de configuração em `/etc/profile.d/` são automaticamente carregados
- O arquivo `.zshrc` é criado com configurações básicas e pode ser personalizado
