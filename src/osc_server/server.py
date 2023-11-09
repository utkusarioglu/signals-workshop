from flask import Flask, render_template
from pythonosc import udp_client
from flask_sock import Sock
import json


def createUdpClient():
    with open("../../.langPort", "r") as specs:
        langPort = int(specs.read())
        print(f"langport: {langPort}")
        return udp_client.SimpleUDPClient("192.168.1.151", langPort)


app = Flask(__name__)
sock = Sock(app)
client = createUdpClient()


@app.route("/")
def root():
    return render_template("index.html")


@sock.route("/ws")
def ws_supercollider(socket):
    while True:
        transmission = json.loads(socket.receive())
        path = f"/{transmission[0]}"
        values = transmission[1:3]
        print(path, values)
        client.send_message(path, values)
