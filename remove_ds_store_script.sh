#!/bin/bash

# Function to remove .DS_Store files
remove_ds_store() {
    find "$1" -type f -name ".DS_Store" -exec rm -f {} \;
}

# Prompt user for Samba share path
read -p "Enter the path to the Samba share: " samba_share

# Confirm the choice
echo -e "\nYou have selected the following Samba share:"
echo "Samba Share: $samba_share"
read -p "Is this correct? (yes/no): " confirm

if [[ $confirm != "yes" ]]; then
    echo "Aborting script. No changes made."
    exit 1
fi

# Remove .DS_Store files
remove_ds_store "$samba_share"

echo ".DS_Store files removed from the Samba share."
