# Reaction Base - A base Docker image for Reaction Commerce

[![Circle CI](https://circleci.com/gh/reactioncommerce/base/tree/master.svg?style=svg)](https://circleci.com/gh/reactioncommerce/base/tree/master)

With the release of Meteor 1.7, we changed the versioning of this repo and it's Docker builds to align with Meteor's release. Henceforth, releases in this repo will be tied to the corresponding Meteor release.

Sample version builds:

| reactioncommerce/base version       | Meteor version  |
| :----------------------------------:|:---------------:|
| v1.7.0.1-meteor                     | v1.7.0.1        |
| v1.7-meteor                         | v1.7            |
| v1.6.1-meteor                       | v1.6.1          |
| v4.0.2                              | v1.6.1          |

See [Docker Hub](https://hub.docker.com/r/reactioncommerce/base/tags/) for full list.

We do not commit to creating a new release of this repo with every Meteor version release. We intend to support versions used by Reaction. Pull requests are welcome for versions not included.

### Adding a new version (Creating a new release)
- Create a directory for the new version (following the existing name convention)
- Update the new Dockerfile as needed.
- Set the TAGS ENV in the `options` file to your release TAG
- Set the Meteor version ENV in the `options` file
- If this new version is the highest tag, search for and remove `latest` from the current options file it's located, and add it to the new options file
- Add any extra test step(s) needed in the `test-sscript.sh`
- Update `History.md` with the new release
- Open a PR to master with the changes.

### Usage

Add the following to a `Dockerfile` in the root of your Reaction Commerce project:

```Dockerfile
FROM reactioncommerce/base:v1.7.0.1-meteor
```

Then you can build the image with this command (after setting your version):

```sh
VERSION=
docker build \
  --build-arg TOOL_NODE_FLAGS="--max-old-space-size=4096" \
  -t reactioncommerce/reaction:${VERSION} .
```

Note: Depending on the type of OS running the build, `--max-old-space-size` may require a different value (e.g 2048). See explanation of the Meteor issue [here](https://github.com/meteor/meteor/issues/8513).

See Reaction's sample Dockerfile using the base image [here](https://github.com/reactioncommerce/reaction/blob/master/Dockerfile).

### Run

Use [docker-compose](https://docs.docker.com/compose/) to run the app. A demo [docker-compose file](https://github.com/reactioncommerce/reaction/blob/master/docker-compose-demo.yml) is included in the Reaction repo.

Run this command to start the app:

```sh
docker-compose -f docker-compose-demo.yml up
```

## License

[MIT License](./LICENSE.md)
