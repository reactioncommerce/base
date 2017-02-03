FROM debian:jessie
MAINTAINER Reaction Commerce <admin@reactioncommerce.com>

RUN groupadd -r node && useradd -m -g node node

ENV NODE_VERSION 4.7.3
ENV GOSU_VERSION 1.10

# Optionally Install MongoDB
ENV INSTALL_MONGO true
ENV MONGO_VERSION 3.4.1
ENV MONGO_MAJOR 3.4

# Optionally Install PhantomJS
ENV INSTALL_PHANTOMJS true
ENV PHANTOM_VERSION 2.1.1

# build directories
ENV APP_SOURCE_DIR /opt/reaction/src
ENV APP_BUNDLE_DIR /opt/reaction/dist
ENV BUILD_SCRIPTS_DIR /opt/build_scripts

# Add entrypoint and build scripts
COPY scripts $BUILD_SCRIPTS_DIR
RUN chmod -R 770 $BUILD_SCRIPTS_DIR

# install base dependencies and clean up
RUN bash $BUILD_SCRIPTS_DIR/install-deps.sh && \
    bash $BUILD_SCRIPTS_DIR/install-node.sh && \
    bash $BUILD_SCRIPTS_DIR/install-mongo.sh && \
    bash $BUILD_SCRIPTS_DIR/install-phantom.sh && \
    bash $BUILD_SCRIPTS_DIR/install-meteor.sh && \
    bash $BUILD_SCRIPTS_DIR/post-install-cleanup.sh

# Default values for Meteor environment variables
ENV ROOT_URL http://localhost
ENV MONGO_URL mongodb://127.0.0.1:27017/reaction
ENV PORT 3000

EXPOSE 3000

WORKDIR $APP_BUNDLE_DIR/bundle

# start the app
ENTRYPOINT ["./entrypoint.sh"]
CMD ["node", "main.js"]
