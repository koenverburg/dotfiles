# /usr/bin/bash

# set -e

##################
# Global variables

# Dotfiles' project root directory
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo $ROOTDIR

# Host file location
HOSTS="$ROOTDIR/ansible/inventory/locals"
echo $HOSTS

# Main playbook
PLAYBOOK="$ROOTDIR/ansible/playbooks/dotfiles.yml"
echo $PLAYBOOK

# Installs ansible
# sudo apt-get update && sudo apt-get install -y ansible

# Runs Ansible playbook using our user.
ansible-playbook -i "$HOSTS" "$PLAYBOOK" --ask-become-pass;
# exit 0;