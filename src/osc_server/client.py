#!/opt/conda/envs/music/bin/python
from sys import argv
from pythonosc import udp_client

args = [float(i) for i in argv[2:]]
target = argv[1]

match target:
    case "scd":
        HOST = "192.168.1.151"
        PORT = 57121
    case "py":
        HOST = "172.30.246.232"
        PORT = 5005

message = ("/thu", args)

print(f"Sending to {target}: {HOST}:{PORT} => {message}")

client = udp_client.SimpleUDPClient(HOST, PORT)
client.send_message(*message)
