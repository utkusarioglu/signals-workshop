import numpy as np
from functools import reduce
import operator
from music21 import note

notes = np.array(list("CDEFGAB"))
octaves = np.array([str(e) for e in range(1, 11)])
pitches = np.core.defchararray.add(*np.meshgrid(notes, octaves)).flatten()
frequencies = {
    note_name: note.Note(note_name).pitch.frequency for note_name in pitches
}


class SoundTools:
    sample_rate = 44100

    @staticmethod
    def create_sound(duration: float, freq: float):
        t = np.arange(0, duration, 1 / SoundTools.sample_rate)
        wave = np.sin(2 * np.pi * t * freq)
        return wave

    @staticmethod
    def create_chord(
        duration: float,
        *notes: str,
    ) -> np.ndarray:
        chord_notes = [
            SoundTools.create_sound(duration, frequencies[note])
            for note in notes
        ]
        return reduce(operator.add, chord_notes)

    @staticmethod
    def create_sequence(*sequence) -> np.ndarray:
        chords = tuple(
            [
                SoundTools.create_chord(
                    duration_and_notes[0],
                    *duration_and_notes[1].strip().upper().split(" "),
                )
                for duration_and_notes in sequence
            ]
        )
        return np.concatenate(chords)
