#!/bin/bash

set -e

# load cache from build job
docker load < ~/docker-cache/image.tar

# download Reaction to test the build
git clone https://github.com/reactioncommerce/reaction.git /tmp/reaction

# make sure we have a compatible Dockerfile in the Reaction dir
cp .circleci/test.Dockerfile /tmp/reaction/Dockerfile

cd /tmp/reaction

# build new image
docker build \
  --build-arg TOOL_NODE_FLAGS="--max-old-space-size=4096" \
  -t reactioncommerce/reaction:latest .

# run the container and wait for it to boot
docker-compose -f .circleci/docker-compose.yml up -d
sleep 30

# use curl to ensure the app returns 200's
docker exec reaction bash -c "apt-get update && apt-get install -y curl && \
  curl --retry 10 --retry-delay 10 -v http://localhost:3000"
