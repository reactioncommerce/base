#!/bin/bash

## Required environment variables in your CircleCI dashboard
# (used to push to Docker Hub)
#
# $DOCKER_USER  - Docker Hub username
# $DOCKER_PASS  - Docker Hub password

set -e

IMAGE_NAME=${DOCKER_IMAGE_NAME:-"reactioncommerce/base"}

# load cache from build job
docker load < ~/docker-cache/image.tar

# create a final release images/tags
docker tag reactioncommerce/base:latest $IMAGE_NAME:$CIRCLE_TAG
docker tag reactioncommerce/base:latest $IMAGE_NAME:latest

# login to Docker Hub
docker login -u $DOCKER_USER --password-stdin $DOCKER_PASS

# push the builds
docker push $IMAGE_NAME:$CIRCLE_TAG
docker push $IMAGE_NAME:latest
