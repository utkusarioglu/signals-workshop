{
  ~synth.isNil.not.if({ ~synth.free });

  SynthDef(\secant, {
    var sig, limit, secant, divisor;

    sig = In.ar(\in.ir);

    secant = (1 / cos(sig * 3)) / 3;
    divisor = MouseX.kr(0.32, 0.35, \linear);
    // secant = cos(sig);
    // secant = sig;

    // secant = tanh(sig) * Saw.ar(5);
    sig = Select.ar(abs(secant) < divisor, [sig, secant]);
    // sig = Lag.ar(sig, 1);

    Out.ar(\out.ir, sig);
  }).add;

  Task {
    s.sync;
    // Synth(\Secant).play;
    ~synth = (
      \instrument: \secant,
      \in: 8,
      \out: 0
    ).play;

    ~synth.postln;
  }.start;
}.();
