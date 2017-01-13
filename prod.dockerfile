FROM reactioncommerce/base:base
MAINTAINER Reaction Commerce <admin@reactioncommerce.com>

# copy the app to the container
ONBUILD COPY . $APP_SOURCE_DIR

# install Meteor, build app, clean up
ONBUILD RUN cd $APP_SOURCE_DIR && \
            bash $BUILD_SCRIPTS_DIR/install-meteor.sh && \
            bash $BUILD_SCRIPTS_DIR/build-meteor.sh && \
            bash $BUILD_SCRIPTS_DIR/post-build-cleanup.sh
