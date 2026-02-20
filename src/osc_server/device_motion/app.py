#!/opt/conda/envs/music/bin/python

from quart import Quart, websocket, render_template
import asyncio
from hypercorn.asyncio import serve
from hypercorn.config import Config
from pythonosc.udp_client import SimpleUDPClient
import os
import sys

config = Config()
config.bind = ["0.0.0.0:5000"]
config.certfile = "ssl/cert.pem"
config.keyfile = "ssl/key.pem"

pid_abspath = sys.argv[1]
print(f"PID at: {pid_abspath}")
with open(pid_abspath, "w") as f:
    f.write(str(os.getpid()))

client = SimpleUDPClient("192.168.1.151", 57120)
app = Quart(__name__)


@app.route("/")
async def main():
    return await render_template("main.html.jinja2", msg="hiii quart")


@app.websocket("/ws")
async def ws():
    while True:
        data = await websocket.receive()
        processed = [int(v) for v in data.split(",")]
        client.send_message("/coordinates", processed)
        print(processed)


asyncio.run(serve(app, config))
