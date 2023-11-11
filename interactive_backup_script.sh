#!/bin/bash

# Function to prompt user for directory path
prompt_for_directory() {
    read -p "Enter the $1 directory path: " directory
    while [ ! -d "$directory" ]; do
        read -p "Invalid directory. Enter a valid $1 directory path: " directory
    done
    echo "$directory"
}

# Prompt user for source and destination directories
source_dir=$(prompt_for_directory "source")
destination_dir=$(prompt_for_directory "destination")

# Confirm the choices
echo -e "\nYou have selected the following directories:"
echo "Source:      $source_dir"
echo "Destination: $destination_dir"
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

# Rsync command
rsync_command="rsync -av --delete \"$source_dir\" \"$destination_dir\""

# Execute rsync command
eval "$rsync_command"
