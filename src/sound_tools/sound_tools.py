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
    duration = 1.5
    sample_rate = 44100

    @staticmethod
    def create_sound(freq: float, duration: float):
        t = np.arange(0, duration, 1 / SoundTools.sample_rate)
        wave = np.sin(2 * np.pi * t * freq)
        return wave

    @staticmethod
    def create_chord(*notes: str) -> np.ndarray:
        chord_notes = [
            SoundTools.create_sound(frequencies[note], SoundTools.duration)
            for note in notes
        ]
        return reduce(operator.add, chord_notes)

    @staticmethod
    def create_sequence(*sequence) -> np.ndarray:
        chords = tuple([SoundTools.create_chord(*notes) for notes in sequence])
        return np.concatenate(chords)
