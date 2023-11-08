SERVER_ABSPATH=$(pwd)/src/osc_server

cd "$SERVER_ABSPATH"

FLASK_DEBUG=1 flask \
  --app 'server' \
  run \
    --host '0.0.0.0' \
    --extra-files "$SERVER_ABSPATH/templates/index.html"
