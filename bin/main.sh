#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

source "bin/settings.sh"

# Process-specific output directories and files
stdout_dir="$output_dir/$$/stdout"
stderr_dir="$output_dir/$$/stderr"
stdout_file="$output_dir/$$/stdout.txt"
stderr_file="$output_dir/$$/stderr.txt"
offline_servers="$output_dir/$$/offline.txt"

# Make the output directories if necessary
mkdir -p "$stdout_dir" "$stderr_dir"

# Print the full path to the base output directory for this process
echo ~/"$remote_dir/$output_dir/$$/"

# Run remote script on each server in background for concurrent execution
sed -n '/^[^#]/p' "$server_list" | while read -r server; do
  # Retrieve and write output; record server as offline if ssh returns nonzero
  ssh "${ssh_config[@]}" "$username@$server" \
      "$remote_dir/$task_script $server" >"$stdout_dir/$server" \
      2>"$stderr_dir/$server" \
      || echo "$server" >>"$offline_servers" &
done

# Wait for all background jobs to finish
wait

# Combine the individual stdout and stderr files
cat "$stdout_dir"/* >"$stdout_file"
cat "$stderr_dir"/* >"$stderr_file"
