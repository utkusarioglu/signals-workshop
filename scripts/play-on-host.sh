#!/bin/bash

# This script watches the path where the exported wave file is expected to be
# And runs a vlc instance on the windows machine if the file changes.

# The script has to be run on the wsl instance because of the following reasons:
# 1- `System.IO.FileSystemWatcher` object in powershell fails to detect changes in
#    wsl paths.
# 2- The docker container is not given access to the sound devices, so it cannot 
#    play a sound file
# Because of the constraints given above, this script runs on the wsl, instance and
# watches the changes introduced by the container to the wav file at `REL_FILE_PATH`
# variable. If there is a change, it calls vlc on windows through powershell to play 
# the file.

REL_FILE_PATH="artifacts/export.wav"

file_abspath_linux="$(pwd)/${REL_FILE_PATH}"
file_abspath_windows='\\wsl$\u-Boulanger'${file_abspath_linux//\//\\}

# This relies on the devcontainer not having dind
# In case docker becomes available inside the devcontainer, this will fail.
if [ -z "$(which docker)" ]; then
  echo "Error: This script needs to be run on the wsl instance, not in the docker container."
  exit 1
fi

if [ -z "$(which inotifywait)" ]; then
    echo "inotifywait not installed."
    echo "Install it through inotify-tools package."
    exit 1
fi
 
counter=0;
 
function execute() {
    counter=$((counter+1))
    echo "Run #$counter" 
    pwsh.exe -command 'C:\Program` Files\VideoLAN\VLC\vlc.exe `
      -I dummy `
      --directx-volume=1.0 `
      --play-and-exit ' \
      $file_abspath_windows
}
 
inotifywait \
  --monitor \
  --format "%e %w%f" \
  --event modify \
  "$file_abspath_linux" \
| while read changed; do
    echo $changed
    execute
done
