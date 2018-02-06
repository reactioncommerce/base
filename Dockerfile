FROM node:8.9.4
MAINTAINER Reaction Commerce <architecture@reactioncommerce.com>

# Meteor
ARG METEOR_VERSION
ENV METEOR_VERSION ${METEOR_VERSION:-1.6.0.1}

# Gosu
ENV GOSU_VERSION 1.10

# provide a way for reaction-cli to detect if we're inside
# an official Reaction Docker build
ENV REACTION_DOCKER_BUILD true

# build directories
ENV APP_SOURCE_DIR /opt/reaction/src
ENV APP_BUNDLE_DIR /opt/reaction/dist
ENV BUILD_SCRIPTS_DIR /opt/reaction/scripts

# Add entrypoint and build scripts
COPY scripts $BUILD_SCRIPTS_DIR
RUN chmod -R 750 $BUILD_SCRIPTS_DIR

RUN $BUILD_SCRIPTS_DIR/install-deps.sh
RUN $BUILD_SCRIPTS_DIR/install-meteor.sh

# Define --build-arg options for final image

# Node flags for the Meteor build tool
ONBUILD ARG TOOL_NODE_FLAGS
ONBUILD ENV TOOL_NODE_FLAGS $TOOL_NODE_FLAGS
