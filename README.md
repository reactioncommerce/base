# Reaction Base - A base Docker image for Reaction Commerce

[![Circle CI](https://circleci.com/gh/reactioncommerce/base/tree/master.svg?style=svg)](https://circleci.com/gh/reactioncommerce/base/tree/master)

With the release of Meteor 1.7, we changed the versioning of this repo and it's Docker builds to align with Meteor's release. Henceforth, releases in this repo will be tied to the corresponding Meteor release.

Current version builds:

| reactioncommerce/base version       | Meteor version  |
| :----------------------------------:|:---------------:|
| v1.7.0.1-meteor                     | v1.7.0.1        |
| v1.7-meteor                         | v1.7            |
| v1.6.1-meteor                       | v1.6.1          |
| v4.0.2                              | v1.6.1          |

See [Docker Hub](https://hub.docker.com/r/reactioncommerce/base/tags/) for full list.

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
docker-compose -f docker-compose-demo.yml up
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
