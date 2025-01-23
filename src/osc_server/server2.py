from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import BlockingOSCUDPServer

ADDRESS = "0.0.0.0"
# ip = "localhost"
PORT = 5005


def print_handler(address, *args):
    print(f"{address}: {args}")


def default_handler(address, *args):
    print(f"DEFAULT {address}: {args}")


dispatcher = Dispatcher()
# dispatcher.map("/example", print_handler)
dispatcher.set_default_handler(default_handler)


print(f"Starting on: {ADDRESS}:{PORT}")
server = BlockingOSCUDPServer((ADDRESS, PORT), dispatcher)
server.serve_forever()  # Blocks forever
