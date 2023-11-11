#!/bin/bash

# Function to prompt user for directory path
prompt_for_directory() {
    read -p "Enter the $1 directory path: " directory
    while [ ! -d "$directory" ]; do
        read -p "Invalid directory. Enter a valid $1 directory path: " directory
    done
    echo "$directory"
}

# Function to prompt user for server information
prompt_for_server() {
    read -p "Enter the $1 server address (IP or hostname): " server
    echo "$server"
}

# Prompt user for source and destination directories
source_dir=$(prompt_for_directory "source")
destination_dir=$(prompt_for_directory "destination")

# Prompt user for destination server information
destination_server=$(prompt_for_server "destination")

# Confirm the choices
echo -e "\nYou have selected the following directories and server:"
echo "Source:      $source_dir"
echo "Destination: $destination_dir"
echo "Destination Server: $destination_server"
read -p "Is this correct? (yes/no): " confirm

if [[ $confirm != "yes" ]]; then
    echo "Aborting script. No changes made."
    exit 1
fi

# Warn about --delete
read -p "WARNING: The --delete option is enabled, which will delete files in the destination not present in the source. Do you want to proceed? (yes/no): " delete_confirm

if [[ $delete_confirm != "yes" ]]; then
    echo "Aborting script. No changes made."
    exit 1
fi

# Rsync command with SSH
rsync_command="rsync -av --delete -e ssh \"$source_dir\" \"$destination_server:$destination_dir\""

# Execute rsync command
eval "$rsync_command"
