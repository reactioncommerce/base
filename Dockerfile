FROM node:8.9.4
LABEL maintainer="Reaction Commerce <architecture@reactioncommerce.com>"

ARG METEOR_VERSION=1.6.1

ENV METEOR_VERSION $METEOR_VERSION
ENV REACTION_DOCKER_BUILD true
ENV APP_SOURCE_DIR /opt/reaction/src
ENV APP_BUNDLE_DIR /opt/reaction/dist
ENV PATH $PATH:/home/node/.meteor

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
