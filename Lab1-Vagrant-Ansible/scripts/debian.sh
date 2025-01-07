#!/bin/bash
echo "vagrant:vagrant" | sudo chpasswd  # Define senha para o usuário vagrant.
echo "root:super_secure_password" | sudo chpasswd  # Define senha para o root.
sudo apt update -y && sudo apt install -y ansible  # Atualiza pacotes e instala o Ansible.
ansible --version  # Verifica se o Ansible foi instalado corretamente.