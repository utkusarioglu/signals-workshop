
r = Routine({
  SynthDef(\aa, { | freq |
    var env, sig, gen;

    gen = Env.adsr();
    env = Env(
      gen,
      doneAction: 2
    );
    sig = SinOsc.ar(freq) * env;
    
    Out.ar(0, sig.dup);
  }).add;
  s.sync;

  Synth(\aa, [freq: 200]);
  "hello".yield;
  Synth(\aa, [freq: 400]);
  "cat".yield;
  Synth(\aa, [freq: 800]);
  2.wait; 
});
