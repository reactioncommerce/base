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
