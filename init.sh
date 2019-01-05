#!/usr/bin/env bash

# EDIT ZONE START
GITHUB_USERNAME="YOUR-GITHUB-USERNAME"
GITHUB_TOKEN="YOUR-GITHUB-TOKEN"
# EDIT ZONE STOP

# Checking if initializing process using parameter or file
if [ $# -eq 2 ]; then
    echo "Initializing $1 page"

    echo "machine api.github.com" >> ~/.netrc  
    echo "  login $1" >> ~/.netrc
    echo "  password $2" >> ~/.netrc

    echo "machine uploads.github.com" >> ~/.netrc  
    echo "  login $1" >> ~/.netrc
    echo "  password $2" >> ~/.netrc

    # If you don't have any credentials configured on git, you need the following lines
    echo "machine github.com" >> ~/.netrc  
    echo "  login $1" >> ~/.netrc
    echo "  password $2" >> ~/.netrc

    chmod 600 ~/.netrc

    # Initializing all data
    echo "GITHUB_USER=$1" > data/profile.txt
    echo "Date,Follower" > data/follower.txt
    echo "Date,Following" > data/following.txt
    echo "Date,Num Repo" > data/num_repo.txt
    echo "Date,Num Users" > data/num_github_users.txt
    echo "Date,Num Users" > data/num_github_users_followers.txt
    echo "Date,Num Users" > data/num_github_users_repo.txt

else
    echo "Please include username and token"
    echo "Usage: $ ./init.sh username token"
fi

