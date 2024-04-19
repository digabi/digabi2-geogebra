#!/usr/bin/env bash

# Get all tags from the remote repository and save them to a variable, in short format
tags=$(git ls-remote --tags --refs origin | awk '{print $2}' | awk -F"/" '{print $3}')

released=$(gh release list --json tagName --jq ".[].tagName")
# filter out the tags that have not been released
unreleased_tags=$(echo "$tags" "$released" | tr ' ' '\n' | sort | uniq -u)

# make tags an selectable list
# check if fzf is installed
if ! command -v fzf &> /dev/null
then
    echo "$unreleased_tags"
    read -r -p "Enter tag to release: " tag_to_release
    echo tag_to_release: "$unreleased_tags"
else
    tag_to_release=$(echo "$unreleased_tags" | tr ' ' '\n' | fzf)
    echo tag_to_release from list: "$tag_to_release"
fi

# using github cli trigger manual workflow with the tag to release as the tag parameter
gh workflow run manual-prod-release.yml -f tag="$tag_to_release"