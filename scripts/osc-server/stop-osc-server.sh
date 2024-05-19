function main {
  flask_id="$(pgrep flask)"
  if [ -z "$flask_id" ]; then
    echo "Info: Flask not running"
    exit 0
  fi
  kill $flask_id
}

main
