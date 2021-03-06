#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
CURRENT_DATE=`date +%Y-%m-%d`
COMMIT_MESSAGE="Profile status at ${CURRENT_DATE}"
source data/profile.txt

pushd $CURRENT_DIR
  # Get number of repositories
  num_repo=0
  page=1
  while : ; do
    temp_num_repo=$(./ok.sh -j list_repos ${GITHUB_USER} per_page=100 page=${page} | grep "full_name" | wc -l | tr -d ' ')
    [[ temp_num_repo -ne "0" ]] || break
    (( num_repo += temp_num_repo ))
    (( page += 1 ))
  done

  #Get number of followers
  num_followers=0
  page=1
  while : ; do
    temp_num_followers=$(./ok.sh -j list_followers ${GITHUB_USER} per_page=100 page=${page} | grep "followers_url" | wc -l | tr -d ' ')
    [[ temp_num_followers -ne "0" ]] || break
    (( num_followers += temp_num_followers ))
    (( page += 1 ))
  done

  # Get number of following
  num_following=0
  page=1
  while : ; do
    temp_num_following=$(./ok.sh -j list_following ${GITHUB_USER} per_page=100 page=${page}  | grep "following_url" | wc -l | tr -d ' ')
    [[ temp_num_following -ne "0" ]] || break
    (( num_following += temp_num_following ))
    (( page += 1 ))
  done

  # Get total number of stars
  num_stars=0
  page=1
  while : ; do
    temp_num_stars=0
    stars=$(./ok.sh -j list_repos ${GITHUB_USER} per_page=100 page=${page} | grep -oP '"stargazers_count": \K([0-9]+)')
    for value in $stars; do
      (( temp_num_stars += value ))
    done
    [[ temp_num_stars -ne "0" ]] || break
    (( num_stars += temp_num_stars ))
    (( page += 1 ))
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

