SynthDef(\aa, { | freq |
  var env, sig;

  env = Env(
    levels: [0, 1, 0.5, 0],
    times: [0.1, 0.2, 0.5, 1],
  ).ar();

  sig = SinOsc.ar(freq) * env;
  Out.ar(0, sig.dup);
}).add;

// s.sync;

a = Routine({
  Synth(\aa, [freq: 400]);
  2.wait;
  Synth(\aa, [freq: 600]);
});

// r.play;
