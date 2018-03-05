METEOR_VERSION_ENV=$(exec env | grep METEOR_VERSION | tr "METEOR_VERSION=" ' ' | xargs);
APP_SOURCE_DIR=$(exec env | grep APP_SOURCE_DIR | tr "APP_SOURCE_DIR=" ' ' | xargs);
APP_BUNDLE_DIR=$(exec env | grep APP_BUNDLE_DIR | tr "APP_BUNDLE_DIR=" ' ' | xargs);

REACTION_CLI_VERSION=$(exec reaction -v | grep Reaction | tr "Reaction CLI:" ' ' | xargs);
INSTALLED_METEOR_VERSION=$(exec meteor --version | tr "Meteor" ' ' | xargs);

APP_SOURCE_DIR_OWNER=$(exec ls -ld "$APP_SOURCE_DIR" | awk '{print $3}');
APP_BUNDLE_DIR_OWNER=$(exec ls -ld "$APP_BUNDLE_DIR" | awk '{print $3}');

# confirm meteor installation
if [ "$INSTALLED_METEOR_VERSION" == "$METEOR_VERSION_ENV" ]; then
  echo "Meteor version confirmed";
else
  echo "Meteor version not found"
  exit 1;
fi

if [ -d "$APP_SOURCE_DIR" ]; then
  echo "APP_SOURCE_DIR exists";
else
  echo "APP_SOURCE_DIR not found";
  exit 1;
fi

if [ -d "$APP_BUNDLE_DIR" ]; then
  echo "APP_BUNDLE_DIR exists";
else
  echo "APP_BUNDLE_DIR not found";
  exit 1;
fi

if [ "$APP_SOURCE_DIR_OWNER" == "node" ]; then
  echo "APP_SOURCE_DIR is owned by user node";
else
  echo "APP_SOURCE_DIR not owned by user node";
  exit 1;
fi

if [ "$APP_BUNDLE_DIR_OWNER" == "node" ]; then
  echo "APP_BUNDLE_DIR is owned by user node";
else
  echo "APP_BUNDLE_DIR not owned by user node";
  exit 1;
fi

exit 0;
