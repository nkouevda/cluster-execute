#!/usr/bin/env bash

# Nikita Kouevda
# 2014/06/04

# Change directory to parent directory of location of script
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# Load settings
. "bin/settings.sh"

# Run the main script remotely
ssh "${ssh_config[@]}" "$username@$server" "$remote_dir/$main_script"
