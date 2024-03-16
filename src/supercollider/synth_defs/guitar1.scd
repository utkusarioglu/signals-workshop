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

  out1 = in;

  out1 = BHiShelf.ar(
    out1,
    freq: krs[4].linexp(0, 1, 20, 20000),
    rs: 1.0,
    db: krs[5].linlin(0, 1, 0, -50),
    mul: 1.0,
    add: 0.0
  );
  out1 = BLowShelf.ar(
    out1, 
    freq: krs[6].linexp(0, 1, 20, 20000), 
    rs: 1.0, 
    db: krs[7].linlin(0, 1, 0, -50),
    mul: 1.0, 
    add: 0.0
  );
  out1 = CrossoverDistortion.ar(
    out1, 
    amp: krs[1].linexp(0, 1, 0.0001, 0.1), 
    smooth: krs[2].linexp(0, 1, 1, 2) - 1, 
    mul: krs[3].linlin(0, 1, 0, 10), 
    add: 0
  );
  out1 = BHiShelf.ar(
    out1, 
    freq: krs[4].linexp(0, 1, 20, 20000),
    rs: 1.0, 
    db: krs[5].linlin(0, 1, 0, -10),
    mul: 1.0, 
    add: 0.0
  );
  out1 = BLowShelf.ar(
    out1, 
    freq: krs[6].linexp(0, 1, 20, 20000), 
    rs: 1.0, 
    db: krs[7].linlin(0, 1, 0, -10),
    mul: 1.0, 
    add: 0.0
  );

  out1 = (out1 * krs[0]) + (in * (1 - krs[0]));

  Out.ar(outBus, out1);
}).add;
