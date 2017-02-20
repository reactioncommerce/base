#!/bin/bash

set -e

printf "\n[-] Installing Meteor $METEOR_VERSION...\n\n"

# download installer script
curl https://install.meteor.com -o /tmp/install_meteor.sh

# set the release version in the install script
sed -i.bak "s/RELEASE=.*/RELEASE=\"$METEOR_VERSION\"/g" /tmp/install_meteor.sh

# install
sh /tmp/install_meteor.sh
