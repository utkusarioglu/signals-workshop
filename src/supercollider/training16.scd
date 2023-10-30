s.boot;

s.waitForBoot({
  var m, music, allOff;

  MIDIClient.init;
  MIDIClient.destinations;

  m = MIDIOut.newByName("LoopBe Internal MIDI", "LoopBe Internal MIDI");

  allOff = {
    (0..127).do({
      arg note;
      (
        type: \midi,
        midiout: m,
        midicmd: \noteOff,
        midinote: note,
      ).play;
      // m.noteOff(0, note, 60);
    });
  };

  music = {
    // var r;

    // r = Routine({
    //   inf.do({
    //     var root = 40;
    //     var speed = 1/8;

    //     [0, 7, 12, 15, 19].do({
    //       arg val;

    //       (
    //         type: \midi,
    //         midiout: m,
    //         midicmd: \noteOn,
    //         midinote: root + val,
    //         sustain: 2,
    //         amp: 0.5,
    //       ).play;

    //       speed.yield;
    //     });
    //   });
    // });

    // r.play;
    var p, q;

    p = Pbind(
      \type, \midi,
      \midiout, m,
      \midicmd, \noteOn,
      \midinote, Pwhite(40, 52, inf),
      \amp, Pexprand(0.1, 0.5, inf),
      \sustain, 0.8,
      \dur, Prand([0.2, 0.4], inf),
    );

    q = p.play;
    wait(10);
    q.stop;
    allOff.();
  };
  
  allOff.();
  music.();
});
