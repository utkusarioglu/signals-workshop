from flask import Flask, render_template
from flask_socketio import SocketIO
from pythonosc import udp_client


def createUdpClient():
    with open("../../.lang_port", "r") as specs:
        langPort = int(specs.read())
        print(f"langPort: {langPort}")
        return udp_client.SimpleUDPClient("192.168.1.151", langPort)


app = Flask(__name__)
app.config["SECRET_KEY"] = "a"
socketio = SocketIO(app)
osc_client = createUdpClient()


@app.route("/")
def root():
    return render_template("index.html")


@socketio.on("json")
def ws_supercollider(transmission):
    path = transmission["path"]
    values = [transmission["channel"], transmission["value"]]
    print(path, values)
    osc_client.send_message(path, values)
