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

Now you can run your container with the following command...
(note that the app listens on port 3000 because it is run by a non-root user for [security reasons](https://github.com/nodejs/docker-node/issues/1) and [non-root users can't run processes on port 80](http://stackoverflow.com/questions/16573668/best-practices-when-running-node-js-with-port-80-ubuntu-linode))

```sh
docker run -d \
  -e ROOT_URL=http://example.com \
  -e MONGO_URL=mongodb://url \
  -e MAIL_URL=smtp://user:pass@mail.example.com:587 \
  -p 3000:3000 \
  reactioncommerce/reaction:latest
```

#### Delay startup

If you need to force a delay in the startup of the Node process (for example, to wait for a database to be ready), you can set the `STARTUP_DELAY` environment variable to any number of seconds.  For example, to delay starting the app by 10 seconds, you would do this:

```sh
docker run -d \
  -e ROOT_URL=http://example.com \
  -e MONGO_URL=mongodb://url \
  -e STARTUP_DELAY=10 \
  -p 3000:3000 \
  reactioncommerce/reaction:latest
```

### Build Options

This base image supports setting custom build options that let you modify what gets installed.  You can use [Docker build args](https://docs.docker.com/engine/reference/builder/#arg) to accomplish this.  The currently supported options are to install PhantomJS or MongoDB.

If you choose to install Mongo, you can use it by _not_ supplying a `MONGO_URL` when you run your app container.  The startup script will start Mongo inside the container and tell your app to use it.  If you _do_ supply a `MONGO_URL`, Mongo will not be started inside the container and the external database will be used instead. (Note that having Mongo in the same container as your app is just for convenience while testing/developing.  In production, you should always use a separate Mongo deployment or at least a separate Mongo container).

When you build your image, you can set any of the following values:

```sh
docker build \
  --build-arg INSTALL_MONGO=true \
  --build-arg INSTALL_PHANTOMJS=true \
  --build-arg NODE_VERSION=8.9.4 \
  -t myorg/myapp:latest .
```

## Docker Compose

Add a `docker-compose.yml` to the root of your project with the following content (edit the app image name to match your build name if needed).

```yaml
# docker-compose.yml

reaction:
  image: reactioncommerce/reaction:latest
  ports:
    - 3000:3000
  links:
    - mongo
  environment:
    - ROOT_URL=http://example.com
    - MONGO_URL=mongodb://mongo:27017/reaction

mongo:
  image: mongo:3.4
```

And then start the app and database containers with...

```sh
docker-compose up -d
```

## License

[MIT License](./LICENSE.md)
