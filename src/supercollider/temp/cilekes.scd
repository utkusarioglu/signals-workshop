var main = {
  s.freeAll;

  SynthDef(\g, { | freq |
    var sig, krs;

    // sig = In.ar(8, 1);
    krs = In.kr(0, 8);
    sig = WhiteNoise.ar();

    // sig = (krs[0] * 0.05 * WhiteNoise.ar()) + ((1 - krs[7]) * sig);
    sig = BHiShelf.ar(
      sig,
      freq: MouseX.kr((s.sampleRate * 0.98), s.sampleRate, \exponential),
      rs: MouseY.kr(0.9, 1, \linear),
      db: krs[0].linexp(0, 1, 1, 100) - 50 ,
      mul: 1
    );
    sig = PitchShift.ar(sig, 0.2, krs[1].linlin(0, 1, 1, 2));
    sig = LPF.ar(sig, krs[2].linexp(0, 1, 20, 2e4));

    Out.ar(0, sig);
  }).add;
  
  (
    instrument: \g,
    // \freq, Pseq([0, 5, 7].collect({ | f | f.midiratio }), 4),
  ).play;
};

main.();
