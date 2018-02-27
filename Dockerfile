FROM node:8.9.4
LABEL maintainer="Reaction Commerce <architecture@reactioncommerce.com>"

ARG METEOR_VERSION=1.6.1

ENV METEOR_VERSION $METEOR_VERSION
ENV GOSU_VERSION 1.10
ENV REACTION_DOCKER_BUILD true
ENV APP_SOURCE_DIR /opt/reaction/src
ENV APP_BUNDLE_DIR /opt/reaction/dist
ENV BUILD_SCRIPTS_DIR /opt/reaction/scripts
ENV PATH $PATH:/home/node/.meteor

COPY scripts $BUILD_SCRIPTS_DIR
RUN chmod -R 750 "$BUILD_SCRIPTS_DIR"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
  build-essential \
  bsdtar \
  bzip2 \
  ca-certificates \
  git \
  python \
  wget \
 && rm -rf /var/lib/apt/lists/*

# Install gosu to build and run the app as a non-root user. https://github.com/tianon/gosu
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
 && GNUPGHOME="$(mktemp -d)" \
 && export GNUPGHOME \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true

RUN npm i -g reaction-cli

USER node

################################
# install-meteor
# replaces tar command with bsdtar in the install script (bsdtar -xf "$TARBALL_FILE" -C "$INSTALL_TMPDIR")
# https://github.com/jshimko/meteor-launchpad/issues/39
################################
RUN wget -O /tmp/install_meteor.sh https://install.meteor.com \
 && sed -i.bak "s/RELEASE=.*/RELEASE=\"$METEOR_VERSION\"/g" /tmp/install_meteor.sh \
 && sed -i.bak "s/tar -xzf.*/bsdtar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install_meteor.sh \
 && printf "\\n[-] Installing Meteor %s...\\n" "$METEOR_VERSION" \
 && sh /tmp/install_meteor.sh \
 && rm /tmp/install_meteor.sh


# Define --build-arg options for final image

# Node flags for the Meteor build tool
ONBUILD ARG TOOL_NODE_FLAGS
ONBUILD ENV TOOL_NODE_FLAGS $TOOL_NODE_FLAGS
