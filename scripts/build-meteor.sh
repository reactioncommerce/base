#!/bin/bash

#
# builds a production meteor bundle directory
#
set -e

# Fix permissions warning in Meteor >=1.4.2.1 without breaking
# earlier versions of Meteor with --unsafe-perm or --allow-superuser
# https://github.com/meteor/meteor/issues/7959
export METEOR_ALLOW_SUPERUSER=true

# CoreOS sometimes has some strange build issues that are fixed by copying the source dir
printf "\n[-] Moving the source folder...\n\n"
cp -R $APP_SOURCE_DIR /opt/copy
cd /opt/copy

# install reaction-cli
npm i -g reaction-cli
ln -sf /opt/nodejs/bin/reaction /usr/local/bin/reaction

# Generate plugin import files
printf "\n[-] Running Reaction plugin loader...\n\n"
reaction plugins load

# Install app deps
printf "\n[-] Running npm install in app directory...\n\n"
meteor npm install

# build the bundle
printf "\n[-] Building Meteor application...\n\n"
mkdir -p $APP_BUNDLE_DIR
meteor build --directory $APP_BUNDLE_DIR > /dev/null

# run npm install in bundle
printf "\n[-] Running npm install in the server bundle...\n\n"
cd $APP_BUNDLE_DIR/bundle/programs/server/
meteor npm install --production

# put the entrypoint script in WORKDIR
mv $BUILD_SCRIPTS_DIR/entrypoint.sh $APP_BUNDLE_DIR/bundle/entrypoint.sh

# change ownership of the app to the node user
chown -R node:node $APP_BUNDLE_DIR

rm -rf /opt/copy
