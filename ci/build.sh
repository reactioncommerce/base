#!/bin/bash

set -e

IMAGE_NAME=${DOCKER_IMAGE_NAME:-"reactioncommerce/base"}

# build the latest
docker build -t $IMAGE_NAME:base .
docker build -f dev.dockerfile -t $IMAGE_NAME:devbuild .
docker build -f prod.dockerfile -t $IMAGE_NAME:latest .

# create a versioned tag for the base image
docker tag $IMAGE_NAME:base $IMAGE_NAME:base-$CIRCLE_TAG

# point the other two Dockerfiles at the versioned base image
sed -i.bak "s/:base/:base-$CIRCLE_TAG/" dev.dockerfile
sed -i.bak "s/:base/:base-$CIRCLE_TAG/" prod.dockerfile

# create the versioned builds
docker build -f dev.dockerfile -t $IMAGE_NAME:devbuild-$CIRCLE_TAG .
docker build -f prod.dockerfile -t $IMAGE_NAME:$CIRCLE_TAG .
