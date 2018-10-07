#!/usr/bin/env bash

# EDIT ZONE START
GITHUB_USERNAME="YOUR-GITHUB-USERNAME"
GITHUB_TOKEN="YOUR-GITHUB-TOKEN"
# EDIT ZONE STOP

# Checking if initializing process using parameter or file
if [ $# -gt 0 ]; then
    echo "Initializing $1 page"
    echo "GITHUB_USER=$1" > data/profile.txt
    echo "GITHUB_TOKEN=$2" >> data/profile.txt

fi

# Initializing all data
echo "Date,Follower" > data/follower.txt
echo "Date,Following" > data/following.txt
echo "Date,Num Repo" > data/num_repo.txt