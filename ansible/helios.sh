#!/usr/bin/bash
set -e

export ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ansible-galaxy install -r ./provision/requirements.yml
ansible-playbook -i ./ansible/inventory/locals ./ansible/playbooks/helios.yml; # --ask-become-pass;
