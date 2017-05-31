FROM reactioncommerce/base:base
MAINTAINER Reaction Commerce <admin@reactioncommerce.com>

# Define all --build-arg options
ONBUILD ARG APT_GET_INSTALL
ONBUILD ENV APT_GET_INSTALL $APT_GET_INSTALL

ONBUILD ARG NODE_VERSION
ONBUILD ENV NODE_VERSION ${NODE_VERSION:-4.8.3}

ONBUILD ARG INSTALL_MONGO
ONBUILD ENV INSTALL_MONGO ${INSTALL_MONGO:-true}

ONBUILD ARG INSTALL_PHANTOMJS
ONBUILD ENV INSTALL_PHANTOMJS ${INSTALL_PHANTOMJS:-true}

# allow setting Node flags for the Meteor build
ONBUILD ARG TOOL_NODE_FLAGS
ONBUILD ENV TOOL_NODE_FLAGS $TOOL_NODE_FLAGS

# copy the app to the container
ONBUILD COPY . $APP_SOURCE_DIR

# build app, clean up
ONBUILD RUN cd $APP_SOURCE_DIR && \
            bash $BUILD_SCRIPTS_DIR/build-meteor.sh && \
            bash $BUILD_SCRIPTS_DIR/post-build-cleanup.sh
