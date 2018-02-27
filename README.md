# Reaction Base - A base Docker image for Reaction Commerce

[![Circle CI](https://circleci.com/gh/reactioncommerce/base/tree/master.svg?style=svg)](https://circleci.com/gh/reactioncommerce/base/tree/master)

### Build

Add the following to a `Dockerfile` in the root of your Reaction Commerce project:

```Dockerfile
FROM reactioncommerce/base:latest
```

Then you can build the image with:

```sh
docker build -t reactioncommerce/reaction:latest .
```

### Run

Use [docker-compose](https://docs.docker.com/compose/) to run the app. A demo [docker-compose file](https://github.com/reactioncommerce/reaction/blob/master/docker-compose-demo.yml) is included in the Reaction repo.

Run this command to start the app:

```sh
docker-compose up -f docker-compose-demo.yml
```

### Build Options

This base image supports setting custom build options that let you modify what gets installed. You can use [Docker build args](https://docs.docker.com/engine/reference/builder/#arg) to accomplish this.

To change the version of Meteor that gets installed, you can specify a version as below:

```sh
docker build \
  --build-arg METEOR_VERSION=1.4.2 \
  -t myorg/myapp:latest .
```

## License

[MIT License](./LICENSE.md)
