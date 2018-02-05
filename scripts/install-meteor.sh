#!/bin/bash

set -e

# download installer script
curl https://install.meteor.com -o /tmp/install_meteor.sh

# set the release version in the install script
# if the Meteor version hasn't been explicitely set, just install the latest
if [[ "$METEOR_VERSION" ]]; then
  # read in the release version in the app
  sed -i.bak "s/RELEASE=.*/RELEASE=\"$METEOR_VERSION\"/g" /tmp/install_meteor.sh
fi

# replace tar command with bsdtar in the install script (bsdtar -xf "$TARBALL_FILE" -C "$INSTALL_TMPDIR")
# https://github.com/jshimko/meteor-launchpad/issues/39
sed -i.bak "s/tar -xzf.*/bsdtar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install_meteor.sh

# install
printf "\n[-] Installing Meteor $METEOR_VERSION...\n\n"
sh /tmp/install_meteor.sh
