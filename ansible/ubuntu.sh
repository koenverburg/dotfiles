#!/usr/bin/bash
set -e

export ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ansible-playbook -i ./ansible/inventory/locals ./ansible/playbooks/dotfiles.yml --ask-become-pass;
