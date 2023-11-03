from flask import Flask
from pythonosc import udp_client
from time import sleep


app = Flask(__name__)
client = udp_client.SimpleUDPClient("192.168.1.151", 57125)


@app.route("/")
def hello_world():
    return "<button onclick=\"fetch('http://192.168.1.151:5000/osc')\">play</button>"


@app.route("/osc")
def osc():
    client.send_message("/aa", 13)
    return {"message": "received"}
