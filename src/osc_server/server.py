from flask import Flask, render_template
from flask_socketio import SocketIO
from pythonosc import udp_client
from json import loads, dumps
from sys import stdout
from utils.supercollider import SuperCollider

supercollider = SuperCollider("../../.scd_specs", "192.168.1.151")

scd_specs = supercollider.getScdSpecs()
control_defaults = scd_specs["controls"]
user_settings = control_defaults.copy()

app = Flask(__name__)
app.config["SECRET_KEY"] = "a"
socketio = SocketIO(app)
osc_client = supercollider.createUdpClient()


@app.route("/")
def root():
    return render_template(
        "index.html", controls=dumps({**control_defaults, **user_settings})
    )


def print_osc_update(path: str, values: list[float]) -> None:
    stdout.write(f"\rOSC: {path} {values}".ljust(40))
    stdout.flush()


@socketio.on("json")
def ws_supercollider(transmission: dict):
    key, channel, value = transmission.values()

    user_settings[key][channel]["default"] = value
    path = f"/{key}"

    message = [channel, value]
    osc_client.send_message(path, message)
    print_osc_update(path, message)
