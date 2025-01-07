# Ambiente Virtualizado com Vagrant e VirtualBox

## Descrição do Projeto
Este projeto configura um ambiente virtualizado para fins de aprendizado em **DevOps** e **infraestrutura**, utilizando **Vagrant**, **VirtualBox** e múltiplas máquinas virtuais. Ele permite automatizar tarefas com ferramentas como o **Ansible** e testar diferentes sistemas operacionais e configurações.

## Estrutura do Ambiente
| Máquina        | Sistema Operacional  | Configuração        | Função                                 |
|----------------|----------------------|---------------------|----------------------------------------|
| **Debian**     | Debian 11 (Bullseye) | 2 CPUs, 1024 MB RAM | Gerenciar o Ansible e realizar testes de automação. |
| **AlmaLinux**  | AlmaLinux 8          | 2 CPUs, 1024 MB RAM | Provisionamento e automação em ambiente Linux. |
| **Windows**    | Windows Server 2019  | 2 CPUs, 2048 MB RAM | Realizar tarefas administrativas e explorar integração híbrida. |

## Configuração do Vagrantfile
Segue o código do **Vagrantfile** configurado para o ambiente:

```ruby
Vagrant.configure("2") do |config|
  config.ssh.insert_key = true
  config.vm.boot_timeout = 600

  # Máquina Debian
  config.vm.define "debian" do |debian|
    debian.vm.box = "debian/bullseye64"
    debian.vm.network "private_network", ip: "192.168.56.101"
    debian.vm.hostname = "debian.lab.local"
    debian.vm.synced_folder "./debian_files", "/home/vagrant/sync", create: true
    debian.vm.provision "shell", path: "scripts/debian.sh"
    debian.vm.provider "virtualbox" do |vb|
      vb.name = "Debian-VM-Lab"
      vb.memory = 1024
      vb.cpus = 2
    end
  end

  # Máquina AlmaLinux
  config.vm.define "almalinux" do |almalinux|
    almalinux.vm.box = "almalinux/8"
    almalinux.vm.network "private_network", ip: "192.168.56.102"
    almalinux.vm.hostname = "almalinux.lab.local"
    almalinux.vm.synced_folder "./almalinux_files", "/home/vagrant/sync", create: true
    almalinux.vm.provision "shell", path: "scripts/almalinux.sh"
    almalinux.vm.provider "virtualbox" do |vb|
      vb.name = "AlmaLinux-VM-Lab"
      vb.memory = 1024
      vb.cpus = 2
    end
  end

  # Máquina Windows Server
  config.vm.define "windows" do |windows|
    windows.vm.box = "mcree/win2019"
    windows.vm.network "private_network", ip: "192.168.56.103"
    windows.vm.hostname = "windows-lab.local"
    windows.vm.synced_folder "./windows_files", "C:\\sync", create: true
    windows.vm.provision "shell", path: "scripts/windows.ps1"
    windows.vm.provider "virtualbox" do |vb|
      vb.name = "Windows-VM-Lab"
      vb.memory = 2048
      vb.cpus = 2
    end
    windows.vm.communicator = "winrm"
    windows.winrm.username = "Administrator"
    windows.winrm.password = "Admin@Super"
  end
end
```

## Scripts de Provisionamento
Os scripts são executados automaticamente após a inicialização das máquinas para configurá-las.

### **Debian (`scripts/debian.sh`)**
```bash
#!/bin/bash
echo "vagrant:vagrant" | sudo chpasswd
echo "root:super_secure_password" | sudo chpasswd
sudo apt update -y && sudo apt install -y ansible
ansible --version
```

### **AlmaLinux (`scripts/almalinux.sh`)**
```bash
#!/bin/bash
echo "vagrant:vagrant" | sudo chpasswd
echo "root:super_secure_password" | sudo chpasswd
sudo dnf update -y && sudo dnf install -y ansible
ansible --version
```

### **Windows (`scripts/windows.ps1`)**
```powershell
New-LocalUser -Name "windowsuser" -Password (ConvertTo-SecureString "SuperSenha123!" -AsPlainText -Force) -FullName "Windows User" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Administrators" -Member "windowsuser"
```

## Problemas Comuns e Soluções
1. **Erro no SSH**:
   - **Erro**: `The SSH command responded with a non-zero exit status.`
   - **Solução**: Verifique se o serviço SSH está ativo e se a chave privada é válida.

2. **Timeout no Boot**:
   - **Erro**: `Timed out while waiting for the machine to boot.`
   - **Solução**: Aumente o `config.vm.boot_timeout` no Vagrantfile.

## Como Usar
1. Clone este repositório:
   ```bash
   git clone https://github.com/rodrigoacelio/Laboratorios-para-DevOps
   cd Laboratorios-para-DevOps
   ```

2. Inicie as máquinas:
   ```bash
   vagrant up
   ```

3. Acesse as máquinas:
   ```bash
   vagrant ssh debian
   vagrant ssh almalinux
   ```

## Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir um PR ou relatar problemas na aba Issues.

## Licença
Este projeto está licenciado sob a MIT License. Consulte o arquivo LICENSE para mais detalhes.