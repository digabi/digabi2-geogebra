#!/usr/bin/env sh

# Get all tags from the remote repository and save them to a variable, in short format
tags=$(git ls-remote --tags --refs origin | awk '{print $2}' | awk -F"/" '{print $3}')

# make tags an selectable list
# check if fzf is installed
if ! command -v fzf &> /dev/null
then
    # print tags and only the last 10
    echo $tags | tr ' ' '\n' | tail -n 10
    read -p "Enter tag to release: " tag_to_release
    echo tag_to_release: $tag_to_release
else
    tag_to_release=$(echo $tags | tr ' ' '\n' | fzf)
    echo tag_to_release from list: $tag_to_release
fi

# using github cli trigger manual workflow with the tag to release as the tag parameter
gh workflow run manual-prod-release.yml -f tag=$tag_to_release