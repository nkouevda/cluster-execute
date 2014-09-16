#!/usr/bin/env bash

# Nikita Kouevda
# 2014/09/16

# Switch to parent directory of location of script
cd "$(dirname "$BASH_SOURCE")/.."

# Load settings
. "bin/settings.sh"

# Run the main script remotely
ssh "${ssh_config[@]}" "$username@$server" "$remote_dir/$main_script"
