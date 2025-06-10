#!/opt/conda/envs/music/bin/python
import os
from music21 import note, tempo, converter, tempo
import time
from pathlib import Path
from pythonosc.udp_client import SimpleUDPClient
from collections import defaultdict

ASSETS_ABSPATH = Path(os.environ["ASSETS_ABSPATH"])
# FILE_ABSPATH = ASSETS_ABSPATH / "MusicXML" / "Muse" / "Hysteria intro.musicxml"
FILE_ABSPATH = ASSETS_ABSPATH / "MusicXML" / "Bland Drums.musicxml"

client = SimpleUDPClient(address="192.168.1.151", port=57121)
score = converter.parse(FILE_ABSPATH)


elems_by_offset = defaultdict(list)
for n in score.flatten():
    elems_by_offset[n.offset].append(n)
sorted_elems_by_offset = sorted(elems_by_offset.keys())

unpitched_mapping = {
    # Kick
    "F4": [36],
    "F5": [
        # Ride
        53,
        # Tambourine
        3,
    ],
    # Ride crash
    "A5": [59],
    # Snare
    "C5": [38],
}


def play(
    osc_endpoint,
    sorted_elems_by_offset,
    unpitched_mapping,
    repeat_count,
):
    current_freq = 1
    for i in range(0, repeat_count):
        prev_offset = -sorted_elems_by_offset[1]
        for offset in sorted_elems_by_offset:
            offset_delta = offset - prev_offset
            prev_offset = offset
            notes = elems_by_offset[offset]
            for n in notes:
                match n:
                    case note.Note():
                        message = [
                            n.pitch.midi,
                            n.seconds,
                            n.volume.velocity or 90,
                        ]
                        client.send_message(osc_endpoint, message)
                        time.sleep(offset_delta * current_freq)
                    case tempo.MetronomeMark():
                        current_freq = 60 / n.number
                    case note.Unpitched():
                        unpitched_list = unpitched_mapping.get(
                            n.displayName, []
                        )
                        for midinote in unpitched_list:
                            client.send_message(
                                osc_endpoint,
                                [
                                    midinote,
                                    n.volume.velocity or 90,
                                ],
                            )
                        time.sleep(offset_delta * current_freq)


def play_bass():
    play("/bass", sorted_elems_by_offset, unpitched_mapping, 1)


def play_drums():
    play("/drums/flat", sorted_elems_by_offset, unpitched_mapping, 4)


play_drums()
