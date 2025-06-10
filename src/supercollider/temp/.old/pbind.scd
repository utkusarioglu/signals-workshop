f = {
  var t;

  SynthDef(\a, { | freq |
    var env, sig;

    env = EnvGen.kr(
      Env.perc,
      doneAction: 2
    );

    sig = SinOsc.ar(freq);
    // sig = sig * env;

    Out.ar(0, sig);
  }).add;

  t = TempoClock.new(2);

  Pbind(
    \instrument, \a, 
    \freq, Pseq([60, 62].collect({ | f | f.midicps}), inf),
  ).play(t);
};

f.();
