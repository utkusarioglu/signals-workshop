SERVER_ABSPATH=$(pwd)/src/osc_server
EXTRA_FILES="$SERVER_ABSPATH/templates/index.html:$(pwd)/.scd_specs"

cd "$SERVER_ABSPATH"

FLASK_DEBUG=1 flask \
  --app 'server' \
  run \
    --host '0.0.0.0' \
    --extra-files "$EXTRA_FILES"
