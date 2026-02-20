#! /bin/bash

if [ -f /tmp/app.pid ]; then
  cat /tmp/app.pid | xargs kill
fi
