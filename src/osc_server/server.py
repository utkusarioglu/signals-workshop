from flask import Flask, render_template
from flask_socketio import SocketIO
from pythonosc import udp_client
from json import loads, dumps


def getSpecs():
    with open("../../.scd_specs", "r") as specs:
        scd_config = loads(specs.read())
        return scd_config


def createUdpClient(scd_specs):
    lang_port = scd_specs["langPort"]
    return udp_client.SimpleUDPClient("192.168.1.151", lang_port)


scd_specs = getSpecs()
app = Flask(__name__)
app.config["SECRET_KEY"] = "a"
socketio = SocketIO(app)
osc_client = createUdpClient(scd_specs)


@app.route("/")
def root():
    return render_template(
        "index.html",
        synth_specs=dumps(scd_specs["synth"]),
        reverb_specs=dumps(scd_specs["reverb"]),
    )


@socketio.on("json")
def ws_supercollider(transmission):
    path = transmission["path"]
    values = [transmission["channel"], transmission["value"]]
    print(path, values)
    osc_client.send_message(path, values)
