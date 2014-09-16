#!/usr/bin/env bash

# Nikita Kouevda
# 2014/09/16

# Switch to parent directory of location of script
cd "$(dirname "$BASH_SOURCE")/.."

# Load settings
. "bin/settings.sh"

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

# Run remote script on each server in a background subshell
for server in "$(grep -vE '^(#|$)' "$server_list")"; do
    (
        # Retrieve and write output
        ssh "${ssh_config[@]}" "$username@$server" \
            "$remote_dir/$task_script $server" >"$stdout_dir/$server" \
            2>"$stderr_dir/$server"

        # Record the server as offline if ssh returned non-0
        (( $? )) && echo "$server" >>"$offline_servers"
    ) &
done

# Wait for all background jobs to finish
wait

# Combine the individual stdout and stderr files
cat "$stdout_dir"/* >"$stdout_file"
cat "$stderr_dir"/* >"$stderr_file"
