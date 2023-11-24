var logSpec = { | name, value |
  [
    "  ", 
    (name ++ ":").padRight(8, " "), 
    value
    ].reduce('++').postln;
};

var logSpecs = { | tempo, speed, root, repeat, sequenceSize |
    "Starting melody:".postln;
    logSpec.("Tempo", tempo);
    logSpec.("Speed", speed);
    logSpec.("Root", root);
    logSpec.("Repeat", repeat);
    logSpec.("Size", sequenceSize);
};

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

    msg.postln;
    sequence = msg;
    sequence.removeAt(0);
    tempo = sequence.removeAt(0);
    speed = sequence.removeAt(0);
    root = sequence.removeAt(0);
    repeat = sequence.removeAt(0);

    TempoClock.tempo = tempo / 60;

    routine.stop;

    if(sequence.size == 0,
    {
      "Skipping empty sequence.".postln;
    }, 
    {
      logSpecs.(tempo, speed, root, repeat, sequence.size);
      routine = Routine({
        repeat.do({
          arg i;

          ("Repeat:" + i).postln;
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
    });
  }, "/melody");
};

routineDefs;
