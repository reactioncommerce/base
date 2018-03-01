#!/bin/bash

set -e

# build the latest
docker build -t reactioncommerce/base:latest .

# save a tar of the image for CI caching
mkdir -p ~/docker-cache
docker save -o ~/docker-cache/image.tar reactioncommerce/base:latest
