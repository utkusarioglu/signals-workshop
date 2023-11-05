from flask import Flask, render_template
from pythonosc import udp_client
from flask_sock import Sock

app = Flask(__name__)
sock = Sock(app)
client = udp_client.SimpleUDPClient("192.168.1.151", 57120)


@app.route("/")
def root():
    return render_template("index.html")


@sock.route("/ws")
def ws_supercollider(socket):
    while True:
        value = socket.receive()
        client.send_message("/cc", value)
