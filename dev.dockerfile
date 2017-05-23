FROM reactioncommerce/base:base
MAINTAINER Reaction Commerce <admin@reactioncommerce.com>

ENV DEV_BUILD true

# allow setting Node flags for the Meteor build
ONBUILD ARG TOOL_NODE_FLAGS
ONBUILD ENV TOOL_NODE_FLAGS $TOOL_NODE_FLAGS

ONBUILD COPY . $APP_SOURCE_DIR
ONBUILD RUN $BUILD_SCRIPTS_DIR/build-meteor.sh
