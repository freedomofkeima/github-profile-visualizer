#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
CURRENT_DATE=`date +%Y-%m-%d`
COMMIT_MESSAGE="Profile status at ${CURRENT_DATE}"
source data/profile.txt

pushd $CURRENT_DIR
  # Get number of repositories
  num_repo=0
  (( num_repo+=$(./ok.sh -j list_repos ${GITHUB_USER} per_page=100 page=1 | grep "full_name" | wc -l | tr -d ' ') ))

  #Get number of followers
  num_followers=0
  (( num_followers+=$(./ok.sh -j list_followers ${GITHUB_USER} per_page=100 page=1 | grep "followers_url" | wc -l | tr -d ' ') ))
  (( num_followers+=$(./ok.sh -j list_followers ${GITHUB_USER} per_page=100 page=2 | grep "followers_url" | wc -l | tr -d ' ') ))
  (( num_followers+=$(./ok.sh -j list_followers ${GITHUB_USER} per_page=100 page=3 | grep "followers_url" | wc -l | tr -d ' ') ))

  # Get number of following
  num_following=0
  (( num_following+=$(./ok.sh -j list_following ${GITHUB_USER} per_page=100 page=1  | grep "following_url" | wc -l | tr -d ' ') ))

  # Get total number of stars
  stars=0
  (( stars+=$(./ok.sh -j list_repos ${GITHUB_USER} per_page=100 page=1 | grep -oP '"stargazers_count": \K([0-9]+)') ))

  num_stars=0
  for value in $stars; do
    (( num_stars += value ))
  done

  # Get total number of Github users
  num_github_users=$(curl -s https://api.github.com/search/users?q=followers:%3E=0 | jq -r '.total_count')

  # Get total number of Github users which has followers higher than yours
  num_github_users_followers=$(curl -s https://api.github.com/search/users?q=followers:%3E${num_followers} | jq -r '.total_count')

  # Get total number of Github users which has repositories higher than yours
  num_github_users_repo=$(curl -s https://api.github.com/search/users?q=repos:%3E${num_repo} | jq -r '.total_count')

  # Append to file
  echo "${CURRENT_DATE},${num_repo}" >> data/num_repo.txt
  echo "${CURRENT_DATE},${num_followers}" >> data/follower.txt
  echo "${CURRENT_DATE},${num_following}" >> data/following.txt
  echo "${CURRENT_DATE},${num_stars}" >> data/num_stars.txt
  echo "${CURRENT_DATE},${num_github_users}" >> data/num_github_users.txt
  echo "${CURRENT_DATE},${num_github_users_followers}" >> data/num_github_users_followers.txt
  echo "${CURRENT_DATE},${num_github_users_repo}" >> data/num_github_users_repo.txt

  # Commit
  git add data/
  git commit -m "${COMMIT_MESSAGE}"
  git push origin master
popd

