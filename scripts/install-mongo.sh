#!/bin/bash

set -e

if [ "$INSTALL_MONGO" = true ]; then
  printf "\n[-] Installing MongoDB ${MONGO_VERSION}...\n\n"

	apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 0C49F3730359A14518585931BC711F9BA15703C6

  echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

	apt-get update

  apt-get install -y \
    mongodb-org=$MONGO_VERSION \
    mongodb-org-server=$MONGO_VERSION \
    mongodb-org-shell=$MONGO_VERSION \
    mongodb-org-mongos=$MONGO_VERSION \
    mongodb-org-tools=$MONGO_VERSION

  mkdir -p /data/{db,configdb}
  chown -R mongodb:mongodb /data/{db,configdb}

	rm -rf /var/lib/apt/lists/*
	rm -rf /var/lib/mongodb
  mv /etc/mongod.conf /etc/mongod.conf.orig

fi
