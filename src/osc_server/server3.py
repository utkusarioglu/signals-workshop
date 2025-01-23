from pythonosc.osc_server import AsyncIOOSCUDPServer
from pythonosc.dispatcher import Dispatcher
import asyncio

ADDRESS = "0.0.0.0"
PORT = 5005


def default_handler(address, *args):
    print(f"DEFAULT: {address}: {args}")


dispatcher = Dispatcher()
dispatcher.set_default_handler(default_handler)


async def init_main():
    server = AsyncIOOSCUDPServer(
        (ADDRESS, PORT), dispatcher, asyncio.get_event_loop()
    )
    transport, protocol = await server.create_serve_endpoint()
    try:
        print(f"Starting on {ADDRESS}:{PORT}")
        await asyncio.Event().wait()
    except KeyboardInterrupt:
        print("Shutting down server.")
    finally:
        transport.close()


asyncio.run(init_main())
