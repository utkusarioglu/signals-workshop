#!/usr/bin/bash

work_dir=/utkusarioglu-com/workshops/signals-workshop/src/supercollider

env_values=()
while [ $# -ne 0 ]; do
  case $1 in
    -p|--preset)
      env_values+=("SC_PRESET=$2")
      shift 2
    ;;
    -f|--file)
      env_values+=("SC_FILE=$2")
      shift 2
    ;;
    *)
      echo "Unknown flag: $1";
      exit 1
  esac
done

exec env "${env_values[@]}" sclang -l $work_dir/sclang_conf.yaml -d $work_dir -r
