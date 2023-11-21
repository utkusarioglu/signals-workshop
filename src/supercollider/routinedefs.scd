
var routineDefs = { | busses | 
  var routine;

  (
    instrument: \FreeVerb2x2,
    reverbCf: busses[\reverb],
    out: 0,
    in: 3,
  ).play;

  OSCdef(\melody, {
    arg msg;
    var sequence, speed, tempo, root, repeat;

    sequence = msg;
    sequence.removeAt(0);
    tempo = sequence.removeAt(0);
    speed = sequence.removeAt(0);
    root = sequence.removeAt(0);
    repeat = sequence.removeAt(0);

    TempoClock.tempo = tempo / 60;

    (
      "Tempo:" + tempo + 
      "Speed:" + speed + 
      "Root:" + root + 
      "Repeat" + repeat + 
      "Length:" + sequence.size
    ).postln;

    routine.stop;
    routine = Routine({
      repeat.do({
        arg i;

        i.postln;
        sequence.do({
          arg value;

          (
            \instrument: \saw3,
            \midinote: root + value,
            \out: 3,
            \synthCf: busses[\synth],
            \spreadThreshold: 100,
          ).play;

          yield(speed);
        });
      });
    });
    routine.play;
  }, "/melody");
};

routineDefs;
