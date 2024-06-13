#!/bin/bash

# Function to update version in a file
update_version() {
    local file=$1
    local search_pattern=$2
    local replace_pattern=$3

    if [[ -f $file ]]; then
        sed -i.bak -E "s/$search_pattern/$replace_pattern/" "$file"
        echo "Updated $file"
    else
        echo "File $file not found"
    fi
}

# Extract version from pubspec.yaml
version=$(grep -E "^version:" pubspec.yaml | sed -E 's/version: ([0-9]+\.[0-9]+\.[0-9]+\+[0-9]+)/\1/')
if [[ -z $version ]]; then
    echo "Version not found in pubspec.yaml"
    exit 1
fi

# Split version into major, minor, patch, and build parts
IFS='+' read -r main_version build <<< "$version"
IFS='.' read -r M m p <<< "$main_version"

# Construct versions for different files
msix_version="$M.$m$p.$build.0"
manifest_version="$M.$m.$p.$build"

echo $msix_version
echo $manifest_version

# Update version in pubspec.yaml msix_config
update_version "pubspec.yaml" "msix_version: [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" "msix_version: $msix_version"

# Update version in /web_chrome_extension/public/manifest.json
update_version "web_chrome_extension/public/manifest.json" "\"version\": \"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\"" "\"version\": \"$manifest_version\""

echo "Version update completed"
