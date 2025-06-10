{
  SynthDef(\sym1, {
    var freq = \freq.ir(440);
    var env = Env.adsr(0.1, 0.5, 0.4, 10, 1).kr(Done.freeSelf, \gate.kr(1));
    var sig = SinOsc.ar(freq);
    sig = sig * env * \vol.ir(0.dbamp);

    // sig = Clip.ar(sig, \threshold.ir(1) * -1, \threshold.ir(1));

    Out.ar(0, sig);
  }).add;

  Routine {
    s.sync;
    ~snd = (
      instrument: \sym1,
      freq: 1000,
      // vol: -20.dbamp,
    ).play;

    3.wait;
    "Set".postln;
    ~snd.release(0);
    // ~snd.set(\gate, 0);
  }.play
}.();
