# Migração para Variável package_manager

## Resumo das Mudanças

As roles do Ansible foram atualizadas para usar uma variável `package_manager` ao invés de `ansible_os_family` para determinar qual gerenciador de pacotes usar.

## Mudanças Implementadas

### Antes
```yaml
- name: Include Debian/Ubuntu tasks
  include_tasks: debian.yml
  when: ansible_os_family == "Debian"

- name: Include Arch Linux tasks
  include_tasks: archlinux.yml
  when: ansible_os_family == "Archlinux"
```

### Depois
```yaml
- name: Include APT-based tasks
  include_tasks: debian.yml
  when: package_manager == "apt"

- name: Include Pacman-based tasks
  include_tasks: archlinux.yml
  when: package_manager == "pacman"
```

## Variável package_manager

A variável `package_manager` é definida nos arquivos `defaults/main.yml` de cada role:

```yaml
package_manager: "{{ 'pacman' if ansible_os_family == 'Archlinux' else 'apt' }}"
```

## Roles Atualizadas

- ✅ `common`
- ✅ `zsh`
- ✅ `python`
- ✅ `nodejs`
- ✅ `docker`
- ✅ `golang` (não precisou de alteração)

## Vantagens

1. **Flexibilidade**: Permite sobrescrever o gerenciador de pacotes via variável
2. **Clareza**: Fica mais claro qual gerenciador está sendo usado
3. **Extensibilidade**: Facilita adicionar suporte a outros gerenciadores (yum, dnf, etc.)

## Como Usar

### Uso Padrão
As roles funcionam automaticamente detectando o sistema operacional.

### Sobrescrever o Gerenciador
```yaml
- hosts: all
  vars:
    package_manager: "pacman"  # Força usar pacman
  roles:
    - common
    - zsh
```

### Adicionar Novo Gerenciador
Para adicionar suporte a um novo gerenciador, basta:

1. Atualizar a variável `package_manager` nos defaults
2. Criar o arquivo de tasks correspondente
3. Adicionar a condição no main.yml

Exemplo para DNF:
```yaml
package_manager: "{{ 'pacman' if ansible_os_family == 'Archlinux' else 'dnf' if ansible_os_family == 'RedHat' else 'apt' }}"
```
