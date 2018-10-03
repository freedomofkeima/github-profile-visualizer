#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

pushd $CURRENT_DIR
  # Get number of repositories
  num_repo=$(./ok.sh -j list_repos ${GITHUB_USER} | grep "full_name" | wc -l)

  #Get number of followers
  num_followers=$(./ok.sh -j list_followers | grep "followers_url" | wc -l)

  # Get number of following
  num_following=$(./ok.sh -j list_following | grep "following_url" | wc -l)

  echo $num_repo
  echo $num_followers
  echo $num_following
popd

