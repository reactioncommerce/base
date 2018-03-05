REACTION_CLI_VERSION=$(reaction -v | grep Reaction);

echo "#### Starting check for correct Meteor installation"
INSTALLED_METEOR_VERSION=$(meteor --version)
if [ "$INSTALLED_METEOR_VERSION" == "Meteor $METEOR_VERSION" ]; then
  echo "Meteor version confirmed";
else
  echo "Error: Expected Meteor version to be $METEOR_VERSION. Found $INSTALLED_METEOR_VERSION"
  exit 1;
fi

echo "#### Starting check for APP_SOURCE_DIR"
if [ -d "$APP_SOURCE_DIR" ]; then
  echo "APP_SOURCE_DIR exists";
else
  echo "Error: APP_SOURCE_DIR $APP_SOURCE_DIR not found";
  exit 1;
fi

echo "#### Starting check for APP_SOURCE_DIR owner"
APP_SOURCE_DIR_OWNER=$(exec ls -ld "$APP_SOURCE_DIR" | awk '{print $3}');
if [ "$APP_SOURCE_DIR_OWNER" == "node" ]; then
  echo "APP_SOURCE_DIR is owned by user node";
else
  echo "Error: APP_SOURCE_DIR not owned by user node";
  exit 1;
fi

echo "#### Starting check for APP_BUNDLE_DIR"
if [ -d "$APP_BUNDLE_DIR" ]; then
  echo "APP_BUNDLE_DIR exists";
else
  echo "Error: APP_BUNDLE_DIR $APP_BUNDLE_DIR not found";
  exit 1;
fi

echo "#### Starting check for APP_BUNDLE_DIR owner"
APP_BUNDLE_DIR_OWNER=$(exec ls -ld "$APP_BUNDLE_DIR" | awk '{print $3}');
if [ "$APP_BUNDLE_DIR_OWNER" == "node" ]; then
  echo "APP_BUNDLE_DIR is owned by user node";
else
  echo "Error: APP_BUNDLE_DIR not owned by user node";
  exit 1;
fi

exit 0;
