from flask import Flask
from pythonosc import udp_client
from time import sleep


app = Flask(__name__)
client = udp_client.SimpleUDPClient("192.168.1.151", 57120)


@app.route("/")
def hello_world():
    variants = sorted([0, 10, 50, 60, 70, 90, 100, 127])
    buttons = [
        f'<button style="height: 200px; width: 100px;" onclick="fetch(\'http://192.168.1.151:5000/osc/{elem}\')">{elem}</button>'
        for elem in variants
    ]
    return "".join(buttons)


@app.route("/osc/<int:value>")
def osc(value):
    client.send_message("/cc", value)
    return {"message": "received"}
