SynthDef(\aaa, { | freq = 300 |
  var gen, env, snd;

  env = Env(
    levels: [0, 1, 0.5, 0],
    times: [0.1, 0.2, 0.5, 1],
  );

  gen = EnvGen.kr(env, doneAction: Done.freeSelf);

  snd = Saw.ar(freq, 0) * gen;

  Out.ar(1, snd);
}).add;

t = Task {
  var name, out, spreadThreshold, common, freqs, steps, tonic, bpm, division;
  tonic = 400;
  steps = [0, 3, 7, 10];
  bpm = 80;
  division = steps.size;

  name = \default;
  out = 0;
  spreadThreshold = 4;
  common = [\out, out, \spreadThreshold, spreadThreshold];
  freqs = steps.collect({ | s |
    tonic * (2 ** (s / 12));
  });
  freqs.postln;

  freqs.do({ | freq |
    Synth(name, [\freq, freq].addAll(common)); 
    (60 / bpm / division).wait;
  });

  // 2.wait;
  // s.freeAll;
};

t.start;
2.wait;
t.pause;
2.wait;
t.resume;
2.wait;
t.stop;
