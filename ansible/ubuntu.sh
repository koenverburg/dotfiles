# /usr/bin/bash

# set -e

##################
# Global variables

# Dotfiles' project root directory
export ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Host file location
export HOSTS="$ROOTDIR/ansible/inventory/locals"

# Main playbook
export PLAYBOOK="$ROOTDIR/ansible/playbooks/dotfiles.yml"

# Installs ansible
# sudo apt-get update && sudo apt-get install -y ansible

# Runs Ansible playbook using our user.
ansible-playbook -i "$HOSTS" "$PLAYBOOK" --ask-become-pass --verbose;
exit 0;