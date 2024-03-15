SynthDef(\Guitar1, { 
  |
    inBus,
    outBus
  |
  var in, krs, mix, room, damp, amp, out1;

  in = In.ar(inBus, 1);
  krs = In.kr(
    Runtime.getBusIndexStart("guitar1"), 
    Runtime.getBusLength("guitar1")
  );

  // amp = krs[0];
  // mix = krs[1];
  // room = krs[2];
  // damp = krs[3];

  // out1 = FreeVerb.ar(
  //   in,
  //   mix,
  //   room,
  //   damp,
  //   4
  //   // add: 0.0
  // );
  out1 = in;
  out1 = HPF.ar(out1, krs[3] * 20000);
  // out1 = DriveNoise.ar(in, amount: 100, multi: 50);
  // out1 = Disintegrator.ar(in, probability: krs[0], multiplier: krs[1], mul: krs[2], add: krs[3]);
  // out1 = Decimator.ar(in, rate: krs[3] * 2000, bits: 8, mul: 1.0, add: 0);
  out1 = CrossoverDistortion.ar(out1, amp: krs[0], smooth: krs[1] * 0.1, mul: 1.0, add: 0);
  out1 = LPF.ar(out1, krs[2] * 20000);

  // outSig1 = Formlet.ar(
  //   in: inSig,
  //   freq: 440.0,
  //   attacktime: 1.0,
  //   decaytime: 1.0,
  //   mul: 1.0,
  //   add: 0.0
  // );

  // outSig1 = GVerb.ar(inSig,
  //   roomsize: 10,
  //   revtime: 3,
  //   damping: 0.5,
  //   inputbw: 0.5,
  //   spread: 15,
  //   drylevel: 1,
  //   earlyreflevel: 0.7,
  //   taillevel: 0.5,
  //   maxroomsize: 300,
  //   mul: 2,
  //   add: 0
  // );
  // outSig1 = AnalogFoldOsc.ar(freq: 100, amp: inSig);
  // outSig1 = JPverb.ar(
  //   inSig,
  //   t60: 1.0,
  //   damp: 0.0,
  //   size: 1.0,
  //   earlyDiff: 0.707,
  //   modDepth: 0.1,
  //   modFreq: 2.0,
  //   low: 1.0,
  //   mid: 1.0,
  //   high: 1.0,
  //   lowcut: 500.0,
  //   highcut: 2000.0
  // );

  Out.ar(outBus, out1);
}).add;
