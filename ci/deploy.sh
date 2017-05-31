#!/bin/bash

set -e

IMAGE_NAME=${DOCKER_IMAGE_NAME:-"reactioncommerce/base"}

# create a versioned tag for the base image
docker tag $IMAGE_NAME:base $IMAGE_NAME:base-$CIRCLE_TAG

# point the other two Dockerfiles at the versioned base image
sed -i.bak "s/:base/:base-$CIRCLE_TAG/" dev.dockerfile
sed -i.bak "s/:base/:base-$CIRCLE_TAG/" prod.dockerfile

# create the versioned builds
docker build -f dev.dockerfile -t $IMAGE_NAME:devbuild-$CIRCLE_TAG .
docker build -f prod.dockerfile -t $IMAGE_NAME:$CIRCLE_TAG .
docker tag $IMAGE_NAME:lean $IMAGE_NAME:$CIRCLE_TAG-lean

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
