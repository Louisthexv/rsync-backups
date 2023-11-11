#!/bin/bash

# Source and destination directories, just replace the source and destination
source_dir="origin directory"
destination_dir="destination directory"

# Rsync command
rsync -av --delete "$source_dir" "$destination_dir"
