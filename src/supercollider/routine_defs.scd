var logKv = ScdLoader.load("log/kv.scd");

var logSpecs = { | tempo, speed, root, repeat, sequenceSize |
    var common = [2, 8];
    "Starting melody:".postln;
    logKv.("Tempo", tempo, *common);
    logKv.("Speed", speed, *common);
    logKv.("Root", root, *common);
    logKv.("Repeat", repeat, *common);
    logKv.("Size", sequenceSize, *common);
};

var guitar = {
  (
    instrument: \Guitar1,
    inBus: 8,
    outBus: 0,
  ).play;

  "Guitar Routine enabled".postln;
};

var python = { 
  var routine;

  (
    instrument: \FreeVerb2x2,
    in: 3,
    out: 0,
  ).play;

  OSCdef(\melody, {
    arg msg;
    var path, sequence, speed, tempo, root, repeat;

    #path, tempo, speed, root, repeat ... sequence = msg;
    // sequence = msg;
    // sequence.removeAt(0);
    // tempo = sequence.removeAt(0);
    // speed = sequence.removeAt(0);
    // root = sequence.removeAt(0);
    // repeat = sequence.removeAt(0);

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

          logKv.("Repeat", i, 4, 8);

          sequence.do({
            arg value;

            (
              \instrument: \saw3,
              \midinote: root + value,
              \out: 3,
              \spreadThreshold: 100,
            ).play;

            yield(speed);
          });
        });
      });
      routine.play;
    });
  }, "/melody");

  "Python routine enabled".postln;
};

var routineDefs = {
  guitar.();
  python.();
};

routineDefs;
