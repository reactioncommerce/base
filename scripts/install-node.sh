#!/bin/bash

set -e

printf "\n[-] Installing Node ${NODE_VERSION}...\n\n"

NODE_DIST=node-v${NODE_VERSION}-linux-x64

cd /tmp
curl -O -L http://nodejs.org/dist/v${NODE_VERSION}/${NODE_DIST}.tar.gz
tar xvzf ${NODE_DIST}.tar.gz
rm ${NODE_DIST}.tar.gz
rm -rf /opt/nodejs
mv ${NODE_DIST} /opt/nodejs

export PATH="$PATH:/opt/nodejs/bin"
