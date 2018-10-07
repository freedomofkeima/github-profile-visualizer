#!/usr/bin/env bash

# EDIT ZONE START
GITHUB_USERNAME="YOUR-GITHUB-USERNAME"
GITHUB_TOKEN="YOUR-GITHUB-TOKEN"
# EDIT ZONE STOP

# Checking if initializing process using parameter or file
if [ $# -gt 0 ]; then
    echo "Initializing $1 page"
    export GITHUB_USER=$1
    export GITHUB_TOKEN=$2
else
    export GITHUB_USER=$GITHUB_USERNAME
    export GITHUB_TOKEN=$GITHUB_TOKEN
fi

# Initializing all data
echo "Date,Follower" > data/follower.txt
echo "Date,Following" > data/following.txt
echo "Date,Num Repo" > data/num_repo.txt

# Check this setup
sh script.sh