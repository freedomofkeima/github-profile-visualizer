#!/usr/bin/env bash

# Get number of repositories
num_repo=$(./ok.sh list_repos ${GITHUB_USER} | grep "full_name" | wc -l)

#Get number of followers
num_followers=$(./ok.sh list_followers | grep "followers_url" | wc -l)

# Get number of following
num_following=$(./ok.sh list_following | grep "following_url" | wc -l)

echo $num_repo
echo $num_followers
echo $num_following
