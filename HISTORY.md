## v1.5.0

- Create a new "lean" build that caches the absolute least amount of app/build dependencies. This brought our final images down from over 2.2GB to under 400MB. CircleCI will now creates these two new builds/tags:
  - `reactioncommerce/base:lean` (equal to "latest" for the lean build)
  - `reactioncommerce/base:v1.2.3-lean` (same image, but version tagged)
- Add build arg options for Mongo, Phantom, and apt-get (see README)
- Switch to unzipping Meteor with bsdtar (fixes [issue when building on some OS's](https://github.com/jshimko/meteor-launchpad/issues/39))
- update Meteor to 1.5

## v1.4.0

- allow setting `TOOL_NODE_FLAGS` for the Meteor at image build time

Example usage:  

```
docker build --build-arg TOOL_NODE_FLAGS="--max-old-space-size=2048" -t reactioncommerce/reaction:latest .
```


## v1.3.1

- Meteor 1.4.4.2
- Node 4.8.2
- Mongo 3.4.4


## v1.3.0

- Meteor 1.4.4.1
- Node 4.8.1
- Mongo 3.4.3


## v1.2.2

- Meteor 1.4.3.2


## v1.2.1

- Don't silence Meteor build logs


## v1.2.0

- Meteor still preinstalled, but we now set the version (currently `1.4.2.7` and can be changed via `$METEOR_VERSION` env var)
- Node 4.7.3
- MongoDB 3.4.2
- Quiet down internal MongoDB logs (if used)
- revert src directory copying from last release (didn't fix anything)


## v1.1.1

- try copying src dir to fix CoreOS cross device error


## v1.1.0

- Preinstall latest version of Meteor


## v1.0.3

- remove numactl


## v1.0.2

- fix `PATH` issues for Node, npm, and reaction-cli


## v1.0.1

- fix global npm `PATH`


## v1.0.0

- initial release as separate project (formerly lived inside the `reactioncommerce/reaction` repo)
