SynthDef(\Guitar1, { 
  |
    out,
    in
  |
  var inSig, krs, mix, room, damp, amp, outSig1, outSig2;

  inSig = In.ar(in, 1);
  krs = In.kr(
    Runtime.getBusIndexStart("guitar1"), 
    Runtime.getBusLength("guitar1")
  );

  amp = krs[0];
  mix = krs[1];
  room = krs[2];
  damp = krs[3];

  // outSig = inSig;
  // outSig = FreeVerb2.ar(
  //     inSig[0],
  //     inSig[1],
  //     mix, room, damp, amp
  // );

  outSig1 = GVerb.ar(inSig,
    roomsize: 10,
    revtime: 3,
    damping: 0.5,
    inputbw: 0.5,
    spread: 15,
    drylevel: 1,
    earlyreflevel: 0.7,
    taillevel: 0.5,
    maxroomsize: 300,
    mul: 2,
    add: 0
  );

  Out.ar(out, outSig1);
}).add;
