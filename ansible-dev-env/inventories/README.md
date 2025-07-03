# Inventários Ansible

Este diretório contém os inventários para diferentes ambientes.

## Inventários Disponíveis

### development
Inventário para desenvolvimento local, executa diretamente na máquina host.

```bash
ansible-playbook -i inventories/development playbooks/setup-dev-env.yml
```

### wsl
Inventário para Windows Subsystem for Linux (WSL).

#### Configuração do WSL

1. **Obter informações do WSL:**
   ```bash
   # No Windows PowerShell, obter IP do WSL
   wsl hostname -I
   
   # Dentro do WSL, verificar o usuário
   whoami
   ```

2. **Configurar SSH no WSL (se necessário):**
   ```bash
   # Dentro do WSL
   sudo apt update
   sudo apt install openssh-server
   sudo service ssh start
   
   # Configurar para iniciar automaticamente
   sudo systemctl enable ssh
   ```

3. **Editar o inventário:**
   - Abra o arquivo `inventories/wsl`
   - Substitua `your_wsl_user` pelo seu usuário WSL
   - Substitua `wsl-ubuntu` pelo hostname ou IP do seu WSL
   - Se usar porta SSH diferente, ajuste `ansible_port`

4. **Configurar chave SSH (recomendado):**
   ```bash
   # No Windows
   ssh-keygen -t rsa -b 4096
   
   # Copiar chave pública para o WSL
   type ~/.ssh/id_rsa.pub | wsl tee -a ~/.ssh/authorized_keys
   ```

5. **Executar playbook:**
   ```bash
   ansible-playbook -i inventories/wsl playbooks/setup-dev-env.yml
   ```

## Variáveis Comuns

Ambos inventários herdam do grupo `development` e compartilham as mesmas roles e configurações.
