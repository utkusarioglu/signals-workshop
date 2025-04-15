var oscInstrument = { | key |
  // var notes = nil ! 128;
  var instrument = MidiBridge.getInstrument(key);

  OSCdef(key, { | msg | 
    // var r;
    msg.postln;
    // instrument.noteOn(msg[1], msg[2], msg[3]);
    // r = Routine({
      "routine start".postln;
      (
        \type: \midi,
        // BUG why does msg start from 2?
        \midiout: instrument,
        \midinote: msg[2],
        \amp: msg[3],
        \dur: msg[4]
        // \velocity: msg[3],
      ).play;

  }, "/" ++ key);
};

oscInstrument;
