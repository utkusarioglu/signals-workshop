from time import sleep


class Chain:
    sequence = []
    log = False

    def __init__(self, supercollider, instrument, log=False) -> None:
        self.supercollider = supercollider
        self.log = log
        self.instrument = instrument

    def note(self, dur, note, amp):
        path = f"/{self.instrument}"
        self.sequence.append({"path": path, "params": [dur, note, amp]})

    def rest(self, dur):
        self.sequence.append({"path": "/rest", "params": [dur]})

    def stream(self):
        for entry in self.sequence:
            self._print(entry)
            self.supercollider.send_osc_message(entry["path"], entry["params"])

            if entry["path"] == "/rest":
                # HACK sleep needs to come from scamp or similar library
                sleep(entry["params"][0])
            else:
                # HACK sleep needs to come from scamp or similar library
                sleep(entry["params"][0])

    def clear(self):
        self.sequence = []

    def _print(self, entry):
        if self.log:
            print(entry["path"], entry["params"])
