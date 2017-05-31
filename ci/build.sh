#!/bin/bash

set -e

IMAGE_NAME=${DOCKER_IMAGE_NAME:-"reactioncommerce/base"}

# build the latest
docker build -t $IMAGE_NAME:base .
docker build -f dev.dockerfile -t $IMAGE_NAME:devbuild .
docker build -f prod.dockerfile -t $IMAGE_NAME:latest .

# create the lean build
docker build -f lean.dockerfile -t $IMAGE_NAME:lean .
