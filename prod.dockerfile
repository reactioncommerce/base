FROM reactioncommerce/base:base
MAINTAINER Reaction Commerce <admin@reactioncommerce.com>

# allow setting Node flags for the Meteor build
ONBUILD ARG TOOL_NODE_FLAGS
ONBUILD ENV TOOL_NODE_FLAGS $TOOL_NODE_FLAGS

# copy the app to the container
ONBUILD COPY . $APP_SOURCE_DIR

# build app, clean up
ONBUILD RUN cd $APP_SOURCE_DIR && \
            bash $BUILD_SCRIPTS_DIR/build-meteor.sh && \
            bash $BUILD_SCRIPTS_DIR/post-build-cleanup.sh
