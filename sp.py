#!/opt/conda/envs/music/bin/python

import subprocess

subprocess.Popen(
    [
        "/mnt/c/Windows/system32/wsl.exe",
        "cmd.exe",
        "/C",
        "scsynth.exe -u 57110",
    ],
)
