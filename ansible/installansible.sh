#!/bin/bash

sudo apt-get update
sudo apt-get install -y python3-pip
sudo -H pip3 install --upgrade pip
sudo -H pip3 install ansible
ansible --version
ansible-galaxy collection install azure.azcollection

wget https://raw.githubusercontent.com/ansible-collections/azure/dev/requirements-azure.txt -O /tmp/requirements-azure.txt
sudo -H pip3 install -r /tmp/requirements-azure.txt
