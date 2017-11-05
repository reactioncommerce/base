FROM debian:jessie
MAINTAINER Reaction Commerce <admin@reactioncommerce.com>

RUN groupadd -r node && useradd -m -g node node

ENV METEOR_VERSION 1.6
ENV GOSU_VERSION 1.10

# Optionally Install MongoDB
ENV MONGO_VERSION 3.4.9
ENV MONGO_MAJOR 3.4

# Optionally Install PhantomJS
ENV PHANTOM_VERSION 2.1.1

# provide a way to detect if we're inside
# an official Reaction Docker build
ENV REACTION_DOCKER_BUILD true

# build directories
ENV APP_SOURCE_DIR /opt/reaction/src
ENV APP_BUNDLE_DIR /opt/reaction/dist
ENV BUILD_SCRIPTS_DIR /opt/build_scripts

# Add entrypoint and build scripts
COPY scripts $BUILD_SCRIPTS_DIR
RUN chmod -R 770 $BUILD_SCRIPTS_DIR

# install base dependencies and clean up
RUN bash $BUILD_SCRIPTS_DIR/install-deps.sh && \
    bash $BUILD_SCRIPTS_DIR/install-meteor.sh && \
    bash $BUILD_SCRIPTS_DIR/post-install-cleanup.sh

# Define all --build-arg options
ONBUILD ARG APT_GET_INSTALL
ONBUILD ENV APT_GET_INSTALL $APT_GET_INSTALL

ONBUILD ARG NODE_VERSION
ONBUILD ENV NODE_VERSION ${NODE_VERSION:-8.9.0}

ONBUILD ARG INSTALL_MONGO
ONBUILD ENV INSTALL_MONGO ${INSTALL_MONGO:-true}

ONBUILD ARG INSTALL_PHANTOMJS
ONBUILD ENV INSTALL_PHANTOMJS ${INSTALL_PHANTOMJS:-true}

# optionally custom apt dependencies at app build time
ONBUILD RUN if [ "$APT_GET_INSTALL" ]; then apt-get update && apt-get install -y $APT_GET_INSTALL; fi

ONBUILD RUN $BUILD_SCRIPTS_DIR/install-node.sh
ONBUILD RUN $BUILD_SCRIPTS_DIR/install-mongo.sh
ONBUILD RUN $BUILD_SCRIPTS_DIR/install-phantom.sh

ONBUILD COPY . $APP_SOURCE_DIR

# allow setting Node flags for the Meteor build
ONBUILD ARG TOOL_NODE_FLAGS
ONBUILD ENV TOOL_NODE_FLAGS $TOOL_NODE_FLAGS

ONBUILD RUN $BUILD_SCRIPTS_DIR/build-meteor.sh

# Default values for Meteor environment variables
ENV ROOT_URL http://localhost
ENV MONGO_URL mongodb://127.0.0.1:27017/reaction
ENV PORT 3000

EXPOSE 3000

WORKDIR $APP_BUNDLE_DIR/bundle

# start the app
ENTRYPOINT ["./entrypoint.sh"]
CMD ["node", "main.js"]
