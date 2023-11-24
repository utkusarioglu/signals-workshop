from pythonosc import udp_client
from json import loads
from typing import Union

PrintSpecs = dict[str, Union[int, float]]


class SuperCollider:
    def __init__(self, specs_path: str, host: str) -> None:
        self.scd_specs = self._loadScdSpecs(specs_path)
        self.host = host

    def send_melody(
        self,
        tempo: float,
        speed: float,
        root: float,
        repeat: int,
        sequence: list[int],
    ):
        osc_client = self.createUdpClient()
        print_specs = {
            "Tempo": tempo,
            "Speed": speed,
            "Root": root,
            "Repeat": repeat,
            "Size": len(sequence),
        }
        message = [tempo, speed, root, repeat, *sequence]
        print(message)
        osc_client.send_message("/melody", message)
        self._print(print_specs)

    def createUdpClient(self):
        lang_port = self.scd_specs["langPort"]
        return udp_client.SimpleUDPClient(self.host, lang_port)

    def getScdSpecs(self):
        return self.scd_specs

    def _loadScdSpecs(self, specs_path: str):
        with open(specs_path, "r") as specs:
            scd_config = loads(specs.read())
            return scd_config

    def _print(self, print_specs: PrintSpecs):
        for key, value in print_specs.items():
            parts = [
                f"{key}:".ljust(8),
                str(value),
            ]
            print("".join(parts))