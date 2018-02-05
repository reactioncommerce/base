FROM node:8
MAINTAINER Reaction Commerce <architecture@reactioncommerce.com>

# Meteor
ARG METEOR_VERSION
ENV METEOR_VERSION ${METEOR_VERSION:-1.6.0.1}

# Gosu
ENV GOSU_VERSION 1.10

# MongoDB
ENV MONGO_VERSION 3.4.11
ENV MONGO_MAJOR 3.4

# PhantomJS
ENV PHANTOM_VERSION 2.1.1

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

# Define all --build-arg options for final image
ONBUILD ARG APT_GET_INSTALL
ONBUILD ENV APT_GET_INSTALL $APT_GET_INSTALL

ONBUILD ARG INSTALL_MONGO
ONBUILD ENV INSTALL_MONGO $INSTALL_MONGO

ONBUILD ARG INSTALL_PHANTOMJS
ONBUILD ENV INSTALL_PHANTOMJS $INSTALL_PHANTOMJS

# Node flags for the Meteor build tool
ONBUILD ARG TOOL_NODE_FLAGS
ONBUILD ENV TOOL_NODE_FLAGS $TOOL_NODE_FLAGS

# install optional dependencies
ONBUILD RUN $BUILD_SCRIPTS_DIR/install-phantom.sh
ONBUILD RUN $BUILD_SCRIPTS_DIR/install-mongo.sh

# optionally install custom apt dependencies
ONBUILD RUN if [ "$APT_GET_INSTALL" ]; then apt-get update && apt-get install -y $APT_GET_INSTALL; fi
