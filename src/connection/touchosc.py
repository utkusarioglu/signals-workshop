from config import ARTIFACTS_RELPATH
from scamp import wait

TOUCHOSC_CONNECTION_PROPS = {
    "name": "touch_osc",
    "ip_address": "touch_osc",
    "port": 9000,
}

def test_run(
    session, part, lowest, highest, step, intervals, repeat_count = 1
):
    session.tempo = 40
    session.start_transcribing()
    sequence = [
        *range(lowest, highest, step),
        *range(highest, lowest, -1 * step),
    ]
    print("Running sequence: ", sequence)
    for repeat in range(repeat_count):
        print("Repeat: ", repeat)
        for pitch in sequence:
            length = 0.1
            velocity = 110
            for interval in intervals:
                part.play_note(
                    pitch + interval, velocity, length, blocking=False
                )
            wait(length)

    tr = session.stop_transcribing()
    tr.save_to_json(f"{ARTIFACTS_RELPATH}/touch_osc.json")
