import numpy as np
from functools import reduce
import operator
from music21 import note

notes = np.array(list("CDEFGAB"))
octaves = np.array([str(e) for e in range(11)])
pitches = np.core.defchararray.add(*np.meshgrid(notes, octaves)).flatten()
frequencies = {
    note_name: note.Note(note_name).pitch.frequency for note_name in pitches
}


class SoundTools:
    sample_rate = 44100

    def __init__(self, beats_per_minute: int):
        self.beats_per_minute = beats_per_minute

    def create_sound(self, wave_type: str, duration: float, freq: float):
        t = np.arange(0, duration, 1 / self.sample_rate)
        match wave_type:
            case "sine":
                wave = np.sin(2 * np.pi * t * freq)
            case "triangle":
                x = 2 * np.pi * freq * t
                wave = np.abs((x / np.pi - 0.5) % 2 - 1) * 2 - 1
            case "square":
                x = 2 * np.pi * freq * t
                wave = np.where(x / np.pi % 2 > 1, -1, 1)
            case _:
                raise ValueError("Unrecognized wave type")
        wave *= 2**15 - 1
        wave = np.int16(wave)
        return wave

    def create_chord(
        self,
        wave_type: str,
        duration: float,
        *notes: str,
    ) -> np.ndarray:
        chord_notes = [
            self.create_sound(wave_type, duration, frequencies[note])
            for note in notes
        ]
        return reduce(operator.add, chord_notes)

    def create_sequence(self, wave_type: str, sequence) -> np.ndarray:
        chords = tuple(
            [
                self.create_chord(
                    wave_type,
                    60.0 / self.beats_per_minute / time,
                    *notes.strip().upper().split(" "),
                )
                for [time, notes] in sequence
            ]
        )
        return np.concatenate(chords)

    def create_orchestration(self, *sequences) -> np.ndarray:
        sequence_signals = [
            self.create_sequence(wave_type, sequence)
            for (wave_type, sequence) in sequences
        ]
        return reduce(operator.add, sequence_signals)
