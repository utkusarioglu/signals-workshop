from pythonosc import udp_client
from json import loads
from typing import Union

PrintSpecs = dict[str, Union[int, float]]
FloatInt = Union[float, int]


class SuperCollider:
    def __init__(self, specs_path: str, host: str) -> None:
        self.scd_specs = self._load_scd_specs(specs_path)
        self.host = host

    def send_melody(
        self,
        tempo: FloatInt,
        speed: FloatInt,
        root: int,
        repeat: int,
        sequence: list[int],
    ):
        osc_client = self.create_udp_client()
        print_specs = {
            "Tempo": tempo,
            "Speed": speed,
            "Root": root,
            "Repeat": repeat,
            "Size": len(sequence),
        }
        message = [tempo, speed, root, repeat, *sequence]
        osc_client.send_message("/melody", message)
        self._print(print_specs)

    def get_lang_port(self):
        return self.scd_specs["langPort"]

    def create_udp_client(self):
        lang_port = self.get_lang_port()
        return udp_client.SimpleUDPClient(self.host, lang_port)

    def get_scd_specs(self):
        return self.scd_specs

    def _load_scd_specs(self, specs_path: str):
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
