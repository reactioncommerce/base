#!/bin/bash

set -e

IMAGE_NAME=${DOCKER_IMAGE_NAME:-"reactioncommerce/base"}

# login to Docker Hub
docker login -u $DOCKER_USER -p $DOCKER_PASS

# push the versioned builds
docker push $IMAGE_NAME:base-$CIRCLE_TAG
docker push $IMAGE_NAME:devbuild-$CIRCLE_TAG
docker push $IMAGE_NAME:$CIRCLE_TAG-lean
docker push $IMAGE_NAME:$CIRCLE_TAG

# push the latest
docker push $IMAGE_NAME:base
docker push $IMAGE_NAME:devbuild
docker push $IMAGE_NAME:lean
docker push $IMAGE_NAME:latest
