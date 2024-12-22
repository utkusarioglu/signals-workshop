var main = {
  s.freeAll;

  SynthDef(\g, {
    var sig, krs;

    sig = In.ar(8, 1);

    krs = In.kr(
      0, 8
      // Runtime.getBusIndexStart("guitar1"), 
      // Runtime.getBusLength("guitar1")
    );

    sig = (krs[7] * 0.05 * WhiteNoise.ar()) + ((1 - krs[7]) * sig);
    // sig = BHiShelf.ar(
    //   sig, 
    //   freq: 2000,
    //   db: -50,
    //   mul: 1
    // );
    // krs[0].postln;
    sig = BHiShelf.ar(
      sig,
      // freq: 2000,
      freq: MouseX.kr(8e4, 96e3, \linear),
      rs: MouseY.kr(0.8, 1, \exponential),
      // freq: krs[0].linexp(0, 1, 20, 2e4),
      // db: -50,
      db: krs[1].linexp(0, 1, 1, 100) - 50 ,
      // db: -20
      mul: 1
    );
    // sig = sig * SinOsc.kr(krs[1].linlin(0, 1, 0, 10));
    // sig = CrossoverDistortion.ar(sig);
    // sig = CrossoverDistortion.ar(sig);
    // sig = BLowShelf.ar(
    //   sig,
    //   freq: krs[0].linexp(0, 1, 20, 1e4),
    //   db: 50,
    //   mul: 1
    // );

    Out.ar(0, sig);
  }).add;
  
  (
    instrument: \g
  ).play;
};

main.();
