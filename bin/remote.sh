#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

source "bin/settings.sh"

# Run the main script remotely
ssh "${ssh_config[@]}" "$username@$server" "$remote_dir/$main_script"
