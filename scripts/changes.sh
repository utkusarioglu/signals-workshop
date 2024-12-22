# su - <<EOF
# catdog

# chmod 1777 /dev/shm
# usermod -aG audio dev

# apt update
# apt install -y libasound2-plugins fluid-soundfont-gm

# mkdir -p /opt/conda/envs/music/lib/alsa-lib
# ln -s /usr/lib/x86_64-linux-gnu/alsa-lib/libasound_module_conf_pulse.so /opt/conda/envs/music/lib/alsa-lib/

# mkdir -p /opt/conda/envs/music/share/soundfonts
# ln -s /usr/share/sounds/sf2/FluidR3_GM.sf2 /opt/conda/envs/music/share/soundfonts/default.sf2
# EOF

USER=dev

su - <<EOF
catdog

apt update
apt install -y alsa-utils acl

usermod -aG audio $USER
setfacl -m u:$USER:rw /dev/snd/*  
EOF
