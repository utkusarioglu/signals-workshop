# log_path="${0%/*}/app1.log"

cd ${0%/*}/src/osc_server/device_motion

# exec > "${log_path}" 2>&1

./app.py /tmp/app.pid
