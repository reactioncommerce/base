FROM reactioncommerce/base:latest as builder
LABEL maintainer="Reaction Commerce <architecture@reactioncommerce.com>"

# copy the app into the build container
COPY . $APP_SOURCE_DIR

# build the app with Meteor
WORKDIR $APP_SOURCE_DIR
RUN printf "\\n[-] Running Reaction plugin loader...\\n" \
 && reaction plugins load
RUN printf "\\n[-] Running npm install in app directory...\\n" \
 && meteor npm install
RUN printf "\\n[-] Building Meteor application...\\n" \
 && export "METEOR_ALLOW_SUPERUSER=true" \
 && mkdir -p "$APP_BUNDLE_DIR" \
 && meteor build --server-only --architecture os.linux.x86_64 --directory "$APP_BUNDLE_DIR"
WORKDIR $APP_BUNDLE_DIR/bundle/programs/server/
RUN meteor npm install --production \
 && mv "$BUILD_SCRIPTS_DIR/entrypoint.sh" "$APP_BUNDLE_DIR/bundle/entrypoint.sh"

# create the final production image
FROM node:8.9.4-slim

WORKDIR /app

# grab the dependencies and built app from the previous builder image
COPY --from=builder /usr/local/bin/gosu /usr/local/bin/gosu
COPY --from=builder /opt/reaction/dist/bundle .

# define all optional build arg's

# MongoDB
ARG INSTALL_MONGO
ENV INSTALL_MONGO $INSTALL_MONGO
ENV MONGO_VERSION 3.4.11
ENV MONGO_MAJOR 3.4

# make sure "node" user can run the app
RUN chown -R node:node /app

# Default environment variables
ENV ROOT_URL "http://localhost"
ENV MONGO_URL "mongodb://127.0.0.1:27017/reaction"
ENV PORT 3000

EXPOSE 3000

# start the app
ENTRYPOINT ["./entrypoint.sh"]
CMD ["node", "main.js"]
