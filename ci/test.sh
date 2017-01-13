#!/bin/bash

set -e

# if we're not on a deployment branch, skip the Docker build/test
if [[ "$CIRCLE_BRANCH" != "master" ]]; then
  echo "Not running a deployment branch. Skipping the Reaction build test."
  exit 0
fi

# install reaction-cli
npm install -g reaction-cli

# get the development branch of Reaction
reaction init -b development
cd reaction

# build an image with the new base
reaction build reactioncommerce/reaction:latest

# run the container and wait for it to boot
docker-compose -f ci/docker-compose.yml up -d
sleep 20

# use curl to ensure the app returns 200's
curl --retry 10 --retry-delay 10 -v http://localhost
