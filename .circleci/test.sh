#!/bin/bash

set -e

# load cache from build job
docker load < ~/docker-cache/image.tar

METEOR_VERSION=$(exec docker run --rm reactioncommerce/base:latest meteor --version)

if [[ $METEOR_VERSION =~ ^Meteor ]]; then
  echo "Meteor install confirmed"
  exit 0;
fi

echo "Meteor install not found"
exit 1;
