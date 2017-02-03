FROM reactioncommerce/base:base
MAINTAINER Reaction Commerce <admin@reactioncommerce.com>

ENV DEV_BUILD true

ONBUILD COPY . $APP_SOURCE_DIR
ONBUILD RUN $BUILD_SCRIPTS_DIR/build-meteor.sh
