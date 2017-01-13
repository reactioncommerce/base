# Reaction Base - A base Docker image for Reaction Commerce

[![Circle CI](https://circleci.com/gh/reactioncommerce/base/tree/master.svg?style=svg)](https://circleci.com/gh/reactioncommerce/base/tree/master)

### Build

Add the following to a `Dockerfile` in the root of your Reaction Commerce project:

```Dockerfile
FROM reactioncommerce/base:latest
```

Then you can build the image with:

```sh
reaction build reactioncommerce/reaction:latest
# or
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
  -p 80:3000 \
  reactioncommerce/reaction:latest
```

#### Delay startup

If you need to force a delay in the startup of the Node process (for example, to wait for a database to be ready), you can set the `STARTUP_DELAY` environment variable to any number of seconds.  For example, to delay starting the app by 10 seconds, you would do this:

```sh
docker run -d \
  -e ROOT_URL=http://example.com \
  -e MONGO_URL=mongodb://url \
  -e STARTUP_DELAY=10 \
  -p 80:3000 \
  reactioncommerce/reaction:latest
```

## Development Builds

You can optionally avoid downloading Meteor every time when building regularly in development.  Add the following to your Dockerfile instead...

```Dockerfile
FROM reactioncommerce/base:devbuild
```

However, this isn't recommended for your final production build because it creates a much larger image, but it's a time saver when you're building often in development.  The first build you run will download/install Meteor and then every subsequent build will be able to skip that step and just build the app.

## Docker Compose

Add a `docker-compose.yml` to the root of your project with the following content (edit the app image name to match your build name if needed).

```yaml
# docker-compose.yml

reaction:
  image: reactioncommerce/reaction:latest
  ports:
    - 80:3000
  links:
    - mongo
  environment:
    - ROOT_URL=http://example.com
    - MONGO_URL=mongodb://mongo:27017/reaction

mongo:
  image: mongo:latest --storageEngine=wiredTiger
```

And then start the app and database containers with...

```sh
docker-compose up -d
```

## License

MIT License

Copyright (c) 2017 Reaction Commerce

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
