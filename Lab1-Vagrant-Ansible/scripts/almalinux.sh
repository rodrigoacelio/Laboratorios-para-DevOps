#!/bin/bash
echo "vagrant:vagrant" | sudo chpasswd
echo "root:super_secure_password" | sudo chpasswd
sudo dnf update -y && sudo dnf install -y ansible
ansible --version
